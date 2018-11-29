pragma solidity ^0.4.24;

import './SafeMath.sol';

/**
 * Here is an example of upgradable contract, consisting of two parts:
 *   - Data Contract keeps the resources (data) and is controlled by the Handler contract;
 *   - Handler contract (implements Handler interface) defines operations and provides services. This contract can be upgraded;
 *
 * @author	Kaidong Wu (wukd94@pku.edu.cn)
 * version	0.1.6
 */

/**
 * The example of Data contract.
 * There are two parts in the Data contract:
 *   - Management Data: owner’s address, Handler Contract’s address and an boolean indicating whether the contract is initialized or not. 
 *   - Resource Data: all resources that the contract needs to keep and mange. Handler control them via getters and setters.
 */
contract DataContract {

	using SafeMath for uint256;

	/** Management Data */
	// Owner and Handler Contract
	address private owner;
	address private handlerAddr;
	
	// Getter permitted
	mapping(address => bool) private addressPermissions;
	
	// Ready?
	bool private ok;
	
	/** Resource Data - Member variables */
	
	/**
	 * Constructor.
	 * Set owner and set this contract to uninitialized.
	 */
	constructor () public {
	    owner = msg.sender;
	    ok = false;
	    addressPermissions[owner] = true;
	}
	
	/** Modifiers */
	
	/**
	 * Check if msg.sender is the Handler contract. It is used for setters.
	 * If fail, throw PermissionException.
	 */
	modifier onlyHandler {
		require(msg.sender == handlerAddr, "Only Handler contract can call this function!");
		_;
	}
	
	/**
	 * Check if msg.sender is not permitted to call getters. It is used for getters (if necessary).
	 * If fail, throw GetterPermissionException.
	 */
	modifier allowedAddress {
		require(addressPermissions[msg.sender], "Do not have the permission!");
		_;
	}
	
	/**
	 * Check if the contract is working.
	 * If fail, throw UninitializationException.
	 */
	modifier ready {
		require(ok, "Data contract has not been initialized!");
		_;
	}
	
	/** Management Functions */
	
	/**
	 * Initializer. just the Handler contract can call it.
	 * 
	 * exception	PermissionException	msg.sender is not the Handler contract.
	 * exception	ReInitializationException	contract has been initialized.
	 *
	 * @return	if the initialization succeeds.
	 */
	function initialize (/** Parameters */) onlyHandler external returns(bool) {
	    require(!ok, "Data Contract has been initialized!");
	    
	    /** Set variables in Data Contract */
	    
	    ok = true;
	    return ok;
	}
	
	/**
	 * Set Handler contract for the contract. Owner must set one to initialize the Data contract.
	 *
	 * @param	_handlerAddr	address of a deployed Handler contract.
     *
	 * exception	PermissionException	msg.sender is not the owner.
	 *
	 * @return	if Handler contract is successfully set.
	 */
	function setHandler (address _handlerAddr) public {
	    require(msg.sender == owner, "Permission error!");
	    addressPermissions[_handlerAddr] = true;
	    addressPermissions[handlerAddr] = false;
	    handlerAddr = _handlerAddr;
	}

	/**
	 * Check if the contract has been initialized.
	 *
	 * @return	if the contract has been initialized.
	 */
	function isReady () view public returns(bool) {
	    return ok;
	}
	
	/** Getters and setters of member variables */
}

/**
 * Handler Contract interface.
 * Handler Contract defines bussiness related functions.
 * Use the interface to ensure that your external services are always supported.
 * Because of function live(), we design IHandler as an abstract contract rather than a true interface.
 *
 * Handler Contract is deployed as following steps:
 *   1. Deploy Data Contract;
 *   2. Deploy a Handler Contract at a given address specified in the Data Contract;
 *   3. Register the Handler Contract address by calling setHandler() in the Data Contract;
 *   4. Initialize Data Contract if haven’t done it already.
 */
contract IHandler {
    
    /**
	 * Initialize the Data Contract.
	 */
    function initialize (/** Parameters */) public;
    
    /**
	 * Let Handler Contract self-destruct.
	 */
    function done () external;
    
    /**
	 * Check if the Handler Contract is a working Handler Contract.
	 * It is used to prove the contract is a Handler Contract.
	 *
	 * @return	always true.
	 */
    function live () pure public returns(bool) {
        return true;
    }
    
    /** Business-related functions */
    
    /** Business-related Events */
}

/**
 * An example implementation of Handler Contract interface
 */
contract Handler is IHandler {
    
	using SafeMath for uint256;
	
	/** Management data */
	// Owner
    address private owner;
	// Data Contract
    address private beanAddr;
	// Cache of data.isReady()
    bool private ready;
    
    /**
	 * Constructor.
	 *
	 * @param	_beanAddr	address of the Data Contract.
	 */
    constructor (address _beanAddr) public {
        owner = msg.sender;
        beanAddr = _beanAddr;
        ready = DataContract(beanAddr).isReady();
    }
    
    /**
	 * Initialize the data contarct.
	 *
	 * exception	PermissionException	msg.sender is not the owner.
	 * exception	ReInitializationException	Data contract has been initialized.
	 * exception	InitializationException	Initialization error.
	 */
    function initialize (/** Parameters */) public {
        require(msg.sender == owner, "Permission error!");
        require(!ready, "Data Contract has been initialized!");
        
        DataContract dc = DataContract(beanAddr);
        
        require(dc.initialize(/** Parameters */), "Initialization error!");
        
        require(ready = dc.isReady(), "Initialization error!");
    }
    
    /**
	 * Let Handler Contract self-destruct.
	 *
	 * exception	PermissionException	msg.sender is not the owner.
	 */
	function done() external{
		require(msg.sender == owner, "Permission error!");
		selfdestruct(owner);
	}

    /** Implementations of business-related functions */
}