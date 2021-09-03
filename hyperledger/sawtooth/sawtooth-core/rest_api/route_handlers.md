# route_handlers.py

This file provides the RouteHandler class which the rest_api utilises to add GET and POST requests and their respective callbacks in rest_api.py.
The RouteHandler itself uses many internal classes defined in other files such as the `Connection`.

What's intriguing i found was that, there's a **submit_batches** method, which does this (in comment):

> Accepts a binary encoded BatchList and **submits it to validator**

What it briefly does is: verify request string is valid (correct Content-Type and non-empty body), creates a `rest_api.protobuf.client_batch_submit_pb2.ClientBatchSubmitRequest(batches)` object, then **sends a request**, using the connection member object...

This function is called on the POST request to /batches.

The connection object itself is connected to the validator port... so I think that validator is also running the server that responds to these requests.

> Also, status code 202, suggests Batches submitted and pending

