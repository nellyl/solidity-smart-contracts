pragma solidity ^0.4.0; 

// Voting system using ethereum blockchain

contract Vote { 

	string[] candidates; // Registered candidates
	mapping (string => uint) votes; // Candidate ID to number of votes
	mapping (address => bool) voters; // Registered voters
	mapping (address => bool) hasVoted; // If a registered voter has voted or not
	
	uint electionEnd; 
	
	// @param _owner The address from which the balance will be retrieved
	function Election(){
        	electionOrganisation = msg.sender;
	}
	
	// @param _owner Only the organisation can launch the contract
	modifier OnlyOrganisationCanLaunchVote() {
        	if (msg.sender != electionOrganisation) throw;
        	_;
	}
    
	// A voter can vote
	modifier VotersCanVote() {
        	if (!voters[msg.sender]) throw;
        _;
	}
    
	// A voter can only vote one time
	modifier VoteOneTime() {
        	if (hasVoted[msg.sender]) throw;
        _;
	}
    
	// A voter can only vote during the election time
	modifier VoteDuringElectionTime() {
        	if (electionEnd == 0 || electionEnd > block.timestamp) throw;
        _;
	}
	
	// @param _owner The duration of an election
	function ElectionStart(uint duration)
        only_election_organisation
	{
        	electionEnd = block.timestamp + duration;
	}
    
	// @param _owner The id of the people you vote for
	function RegisterCandidat(string id)
        only_election_organisation
	{
        	candidates.push(id);
	}
    
	// A voter registered
	function VoterRegister(address add)
        only_election_organisation
	{
        	voters[add] = true;
	}
    
	// A voter has voted according to terms
	function Vote(string id)
        only_registered_voters
        vote_only_once
        only_during_election_time
	{
        	votes[id] += 1;
        	hasVoted[msg.sender] = true;
	}
    
	// @param _owner void
	// @return The number of candidate
	function GetNumberCandidate() constant returns(uint) {
        	return candidates.length;
	}
    
	// @param _owner The number of the candidate
	// @return his name and the number of voters for him 
	function GetCandidate(uint i)
        constant returns(string _candidate, uint _votes)
	{
        	_candidate = candidates[i];
        	_votes = votes[_candidate];
	}
	
}
