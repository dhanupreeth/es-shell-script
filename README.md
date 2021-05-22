# ES Basic curl Commands

### To the know the Cluster Settings
```curl -XGET 'localhost:9200/_cluster/settings' | jq '.'
```
### To know the Index List
```curl -XGET 'http://localhost:9200/_cat/indices' | jq '.'
```
### To know the UNASSIGNED Shards Index Name and List
```curl -XGET localhost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason| grep UNASSIGNED
```
```curl -s "http://127.0.0.1:9200/_cat/shards?v" | awk 'NR==1 {print}; $4 == "UNASSIGNED" {print}'
```
### To update the Routing and Allocation Settings in the Cluster
```curl -XPUT 'localhost:9200/_cluster/settings' -d '{ "transient" : { "cluster.routing.allocation.enable" : "all" } }'
```
### To know the details info about the reroute
```curl -XPOST "http://localhost:9200/_cluster/reroute?explain"
```
### Manually Updating the Unassigned Shards to the Particular Node, it requires ES Service Restart
```curl -XPOST 'localhost:9200/_cluster/reroute' -d '{ "commands": [{ "allocate": { "index": "Index-Name", "shard": 4, "node": "node-Name" } }] }'
```
### To know the allocations of Shars and Replicaions
```curl -s 'localhost:9200/_cat/allocation?v'
```
# To list all the Shards from the Cluster
```curl -XGET localhost:9200/_cat/shards?
```


