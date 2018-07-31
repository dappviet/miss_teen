pragma solidity ^0.4.24;

contract MissTeen {

	// Candidate data struct
	struct Candidate {
		uint id;
		string name;
		string photoUrl;
		uint voteCount;
	}

	// Store candidates
	mapping(uint => Candidate) public candidates;

	// Store voters information
	mapping(address => bool) public voters;

	// Track number of voters
	uint numOfCandidate;

	event votedEvent (
		uint indexed _candidateId
	);

	// Constructor
	constructor () public {
		addCandidate("Tram Anh", "http://www.dappviet.com/images/tramanh.jpg");
		addCandidate("Tram Anh", "http://www.dappviet.com/images/myduyen.jpg");	
	}

	function addCandidate (string _name, string _photoUrl) private {
		numOfCandidate++;
		candidates[numOfCandidate] = Candidate(numOfCandidate, _name, _photoUrl, 0);
	}

	function vote (uint _candidateId) public {
		
		// Require voter never voted before
		require(!voters[msg.sender]);

		require(_candidateId > 0 && _candidateId <= numOfCandidate);

		voters[msg.sender] = true;

		candidates[_candidateId].voteCount ++;

		// create voted event
		votedEvent(_candidateId);

	}
}