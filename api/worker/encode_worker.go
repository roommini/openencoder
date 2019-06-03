package worker

import (
	"github.com/alfg/enc/api/types"
	log "github.com/sirupsen/logrus"
)

var Jobs chan types.Job

// NewWorker creates a new worker instance to listen and process jobs in the queue.
func NewWorker(maxWorkers int, maxQueueSize int) {
	Jobs = make(chan types.Job, maxQueueSize)

	// create workers.
	for i := 1; i <= maxWorkers; i++ {
		go func(i int) {
			for j := range Jobs {
				startJob(i, j)
			}
		}(i)

		// wg := &sync.WaitGroup{}
		// wg.Add(1)

		// // Listen to encode queue.
		// decodeConfig := nsq.NewConfig()
		// c, err := nsq.NewConsumer("encode", "encode_channel", decodeConfig)
		// if err != nil {
		// 	log.Panic("Could not create consumer")
		// }
		// //c.MaxInFlight defaults to 1

		// job := &types.Job{}

		// // NSQ handler for incling messages.
		// c.AddHandler(nsq.HandlerFunc(func(message *nsq.Message) error {
		// 	log.Println("NSQ message received:")
		// 	log.Println(string(message.Body))

		// 	// Decode message body.
		// 	buf := bytes.NewBuffer(message.Body)
		// 	dec := gob.NewDecoder(buf)
		// 	err = dec.Decode(job)
		// 	if err != nil {
		// 		log.Println("Error decoding job")
		// 	}

		// 	// Start the encode job.
		// 	startJob(*job)
		// 	return nil
		// }))

		// // Connect to queue.
		// err = c.ConnectToNSQD("127.0.0.1:4150")
		// if err != nil {
		// 	log.Panic("Could not connect")
		// }
		// log.Println("Awaiting messages from NSQ topic: encode")
		// wg.Wait()
	}
}

func startJob(id int, j types.Job) {
	log.Infof("worker: started %s\n", j.Profile)

	// runWorkflow(j)
	runEncodeJob(j)
	log.Infof("worker%d: completed %s!\n", j.Profile)
}
