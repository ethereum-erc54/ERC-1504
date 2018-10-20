##ERC standards to move Ethereum forward? ERC-20, ERC-223, ERC-721.
##ERC-20 is a well-known term in the Ethereum and ICO community.

For the last few years, I’ve been consulting and contributing to various teams, helping them with token sale projects. Therefore, I had an opportunity to take a closer look at ERC standards, analyse and compare them.

The information below should be valuable for every investor and ICO entrepreneur to understand what is hiding behind ERC standards.


What does ERC mean?
ERC stands for Ethereum Request for Comments. An ERC is authored by Ethereum community developers in the form of a memorandum describing methods, behaviors, research, or innovations applicable to the working of the Ethereum ecosystem. It is submitted either for peer review or simply to convey new concepts or information. After core developers and community approval, the proposal becomes a standard.

Therefore, as a result, we have a set of standards or proposals (e.g. for tokens). Actually, these rules are simple set of functions that Smart Contract should implement. In return, contracts, implementing the standard can be used via a single interface. The best example is ERC-20 standard. All Smart Contracts implementing this standard, by default can be listed to crypto exchanges without any extra technical work.

ERC-20
It is the most common and well-known standard within all crypto community. 99% (if not all) issued ICO tokens on top of the Ethereum implements this standard. Actually, it is just a simple set of functions that your token code has to have. For those who can read the code, the contract below is very simple to understand.

contract ERC20 {
  function transfer(address _to, uint256 _amount) returns (bool success);
  function transferFrom(address _from, address _to, uint256 _amount) returns (bool success);
  function balanceOf(address _owner) constant returns (uint256 balance);
  function approve(address _spender, uint256 _amount) returns (bool success);
  function allowance(address _owner, address _spender) constant returns (uint256 remaining);
  function totalSupply() constant returns (uint);
}
The key benefit we get here, is that any application or other smart contract can interact with a token in a standard manner without a need of knowing other details about the token.

Therefore, we have a very pleasant way to create any ICO token and have a standard way to interact with all of them like they are all the same. For instance, crypto wallet developers can avoid custom development and integrations to add new tokens. All they need to know is the Ethereum Token address that implements the standard.

ERC-223
This proposal was introduced by a developer, who decided to solve issues with current ERC-20 standard for tokens. Below I excluded main features of this proposed standard.

Advantages:

Provides the possibility of avoiding accidentally lost tokens inside contracts that are not designed to work with sent tokens. However, these accidental transfers, which are uncommon already, will probably become more uncommon with ENS in the future.
ERC-223 transfer to contracts consumes less gas than ERC-20.
Disadvantages and risks:

ERC-223 is a proposal right now, not a standard. Therefore, there are none of the high-profile ICO tokens deployed with this standard. Also it is not yet implemented in any production tokens that I found from my research.
Exchanges might need to do some modifications in order to support such token. There is options that some of the exchanges might not be prepared for it yet.

http://cryptocurry.com/
In my opinion, the benefits that this standard brings are not that high compared to risks of using unofficial token interface, which is not yet accepted by Ethereum foundation and is not a standard.

ERC-721
The goal of this proposal, is to create a non-fungible token. In ERC-20 and ERC-223 standards we have a supply of tokens, where tokens are fungible (i.e. single unit of that token is equal to another unit). This makes it easy to trade those tokens, as all of the token supply can be treated in the same manner.

However, there are various cases when you need to have unidentical tokens, which are used within the platform, and add some extra parameters and price them differently. For instance, we could have a token which represents some part of real estate object, and each token might have some different parameters added to it. Or in WePower case, tokenised electricity tokens cannot be treated the same, as each of it might represent different time frame, amount or even type of energy (solar, wind, hydro).


WePower Token example
Such standard would make it easy to create marketplaces for multiple non-fungible token types.

It is just a proposal yet, but hopefully someday Ethereum foundation will accept this standard and include it to the list.

Other ERC standards
There are many more proposals that should make the whole standardisation for Ethereum community better. It will just take time to agree and approve standards and adopt it to actually be used as it is with ERC-20.
