# Test argo events

## Webhooks

```sh
kubectl exec -ti curl-client -- sh

curl -X POST http://webhook-eventsource-svc.default.svc.cluster.local:12000/trigger -d '{"message":"hello"}' -H "Content-Type: application/json"
```
