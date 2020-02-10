pragma solidity ^0.4.25;

contract SmartContract_JFRN {
   
    event Insert_Data(string name, string hash, uint timestamp);
   
    struct Data {
        string name;
        string hash;
        uint timestamp;
        address owner;
    }
   
    mapping (string => Data) private hashToData;
   
    function write_Data(string _name, string _hash) public {
        require(!verify_Data(_hash));
        uint timestamp = now;
        hashToData[_hash] = Data(_name, _hash, timestamp, msg.sender);
        emit Insert_Data(_name, _hash, timestamp);
    }
   
    function verify_Data(string _hash) public view returns (bool) {
        
        if ((keccak256(abi.encodePacked(hashToData[_hash].hash)) == keccak256(abi.encodePacked("")))) {
            return false;
        }
        return true;
    }
   
    function read_Data(string _hash) public view returns (string, string, uint, address) {
        return (hashToData[_hash].name, hashToData[_hash].hash, hashToData[_hash].timestamp, hashToData[_hash].owner);
    }
}