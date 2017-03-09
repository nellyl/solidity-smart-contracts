# solidity-smart-contracts
LAM Nelly 
HAMIDI Melinda
ZHANG Yan

pragma solidity ^0.4.0;
contract Voting {

    struct Candidate {

        uint votecount;

        string name;

    }

    struct Voter {

        bool voted;

    }

    mapping(address => Voter) public voters;

    Candidate[] public candidates;

    function Vote() {

        candidates.push(Candidate({

                name: “candidate1”,

                votecount: 0

            }));

        candidates.push(Candidate({

                name: “candidate2”,

                votecount: 0

            }));

      }

    function Vote_candidate(uint8 numCandidate)

    {

        if(voters[msg.sender].voted ||numCandidate>candidates.length)return;

        candidates[numCandidate].votecount+=1;

        voters[msg.sender].voted=true;

    }

  function Getcount() returns(string,uint,string,uint){

        return(candidates[0].name,candidates[0].votecount,candidates[1].name,candidates[1].votecount);

    }

}
