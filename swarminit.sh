# Swarm mode using Docker Machine

#Specify worker and managers here
managers=1
workers=2

    # create manager machines
	echo "======> Creating $managers manager machines ...";
	for node in $(seq 1 $managers);
	do
		echo "======> Creating managernode$node machine ...";
		docker-machine create -d virtualbox managernode$node;
	done

    # create worker machines
	echo "======> Creating $workers worker machines ...";
	for node in $(seq 1 $workers);
	do
		echo "======> Creating workernode$node machine ...";
		docker-machine create -d virtualbox workernode$node;
	done

# list all machines
docker-machine ls

# initialize swarm mode and create a manager(swarm init)
echo "======> Initializing first swarm manager ..."
docker-machine ssh managernode1 "docker swarm init --listen-addr $(docker-machine ip managernode1) --advertise-addr $(docker-machine ip managernode1)"

	# get manager and worker tokens(join tokens)
	export manager_token=`docker-machine ssh managernode1 "docker swarm join-token manager -q"`
	export worker_token=`docker-machine ssh managernode1 "docker swarm join-token worker -q"`

	echo "manager_token: $manager_token"
	echo "worker_token: $worker_token"

# show members of swarm
docker-machine ssh managernode1 "docker node ls"

	# workers join swarm params
	#  --listen-addr $(docker-machine ip workernode$node) \
	# --advertise-addr $(docker-machine ip workernode$node) \
	for node in $(seq 1 $workers);
	do
		echo "======> workernode$node joining swarm as worker ..."
		docker-machine ssh workernode$node \
		"docker swarm join \
		--token $worker_token \
		$(docker-machine ip managernode1):2377"
	done

# show members of swarm
docker-machine ssh managernode1 "docker node ls"

# Cleanup
# # Stop machines
docker-machine stop workernode1 workernode2  managernode1 
# # remove machines
docker-machine rm workernode1 workernode2  managernode1 