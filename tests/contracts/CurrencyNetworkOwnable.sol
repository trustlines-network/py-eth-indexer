pragma solidity ^0.8.0;

// This class has to be called CurrencyNetwork, because we need to be compatible with
// logdecode.build_address_to_abi_dict
//
// We build the contracts.json manually and remove the abi for the UnknownAbiEvent to test
// having an event without its abi

contract CurrencyNetworkOwnable {
  event Transfer(address indexed _from, address indexed _to, uint _value);
  event UnknownAbiEvent(int _value);

  constructor() {
  }

  function makeTransfer(address _from, address _to, uint _value) public {
    emit Transfer(_from, _to, _value);
  }

  function emitUnknownAbiEvent() public {
    emit UnknownAbiEvent(42);
  }
}
