# ES Basic curl Commands

### To the know the Cluster Settings
```bash
curl -XGET 'localhost:9200/_cluster/settings' | jq '.'
```
### To know the Index List
```bash
curl -XGET 'http://localhost:9200/_cat/indices' | jq '.'
```
### To know the UNASSIGNED Shards Index Name and List
```bash
curl -XGET 'http://localhost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason| grep UNASSIGNED'
```
```bash
curl -s "http://127.0.0.1:9200/_cat/shards?v" | awk 'NR==1 {print}; $4 == "UNASSIGNED" {print}'
```
### To update the Routing and Allocation Settings in the Cluster
```bash
curl -XPUT 'localhost:9200/_cluster/settings' -d '{ "transient" : { "cluster.routing.allocation.enable" : "all" } }'
```
### To know the details info about the reroute
```bash
curl -XPOST "http://localhost:9200/_cluster/reroute?explain"
```
### Manually Updating the Unassigned Shards to the Particular Node, it requires ES Service Restart
```bash
curl -XPOST 'localhost:9200/_cluster/reroute' -d '{ "commands": [{ "allocate": { "index": "Index-Name", "shard": 4, "node": "node-Name" } }] }'
```
### To know the allocations of Shars and Replicaions
```bash
curl -s 'localhost:9200/_cat/allocation?v'
```
# To list all the Shards from the Cluster
```bash
curl -XGET localhost:9200/_cat/shards?
```


