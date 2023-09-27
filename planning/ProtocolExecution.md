

Running a protocol:
1. Press play on a Symphony Protocol
2. Start handling the first Epoch
3. didControllerStartHardware: start SLO acquisition, send trigger back (?)
4. completeEpoch: stop SLO acquisition, grab associated file names, import some data if not too time consuming (otherwise do it on completeRun), PAUSE and open up QueueController
5. When user presses GO on QueueController, resume and move on to next epoch.


Can we stop an epoch midway through without aborting the full run???

**QueueController** - we often need to adjust things before next stimulus runs. We will also want this anytime we have to pause acquisition mid-run as runs are going to be longer than standard ephys trials.
- Play next stimulus?
- Repeat last stimulus?
- Add repeat to end of queue?
- Notes?

