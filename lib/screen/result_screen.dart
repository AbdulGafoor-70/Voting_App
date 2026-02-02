import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/voting_provider.dart';
import '../model/model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final votingProvider = Provider.of<VotingProvider>(context);
    final bool isTie = votingProvider.isTie;
    final winners = votingProvider.winners;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Voting Result"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: votingProvider.candidates.length,
              itemBuilder: (context, index) {
                final Candidate candidate =
                    votingProvider.candidates[index];

                final bool isWinner = winners.any(
                  (c) => c.id == candidate.id,
                );

                return ListTile(
                  title: Text(
                    candidate.name,
                    style: TextStyle(
                      fontWeight:
                          isWinner ? FontWeight.bold : FontWeight.normal,
                      color: isWinner ? Colors.green : Colors.black,
                    ),
                  ),
                  trailing: Text("Votes: ${candidate.votes}"),
                  subtitle: isWinner
                      ? Text(
                          isTie ? "Tie for winner" : "Winner",
                          style: const TextStyle(color: Colors.green),
                        )
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              isTie ? "It's a tie!" : "Winner",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isTie ? Colors.red : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
