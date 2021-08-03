# Putting all pieces of Client Code in place

<!--Ye sayad is repo pe pehla note hai, jo exclusively second person ko batate hue type me likha hua hai, in rest, khud se hi baat karte type hai-->

> More detailed and the original source for all this info: https://sawtooth.hyperledger.org/docs/core/nightly/master/_autogen/sdk_submit_tutorial_rust.html

> NOTE: This is only complementary to the above link
> NOTE2: Depending on language, it will be more verbose or small like these examples

So, the steps...
1. Create payload 'bytes'
2. Create a `Transaction` object from these bytes
3. Create a `BatchList` from the `Transaction` object (intermediary is a `Batch` object)
4. Send transaction to `_rest-api-url_/batches`

### 0. Prerequisite

Though NOT mandatory, but we generally will create atleast a `Client` class, which has all the functions *then those will call/implement the above parts*.

For eg. a simple client class in C++ -
```cpp
using std::string;

class AppClient {
    string rest_api_url;
    public:
    AppClient(string url): rest_api_url(url) {    // for eg. http://rest-api:8008
        // Create a signer object here, or maybe later, in any step before it is required
    }

    void get(string var_name); 
    void set(string var_name, int value); 
    void list(); 
}
```

### 1. Creating payload bytes

Now, note that finally what matters is **payload bytes**, examples in doc show a `Payload` class for simplicity, though you may have different payload structure for each, finally all are converted to bytes for later steps.

For eg.
```cpp
using std::string;

struct SetPayload { string name; int val; }

void AppClient::set(string var_name, int val) {
    const auto& payload = SetPayload{var_name, val};
    const auto& payload_bytes = convert_to_bytes(payload);
}
```

The `convert_to_bytes` function is specific to your choice, for eg. if using protobuf or serde, no need to implement it yourself, there is functions like `write_to_buffer` etc. that do this

### 2. Creating a `Transaction` object

This is divided into two substeps:
1. Create TransactionHeader
2. Create Transaction object

> Jitna mai notice kiya, us hisaab se, TransactionHeader may take more effort than the final Transaction object

```cpp
void AppClient::set(string var_name, int val) {
    // ...

    auto header = TransactionHeader();
    header.set_family_name("intkey");
    header.set_family_version("1.0");

    // Generate a random 128 bit number to use as a nonce
    array<uint8_t,16> nonce;
    thread_rng()
        .try_fill(nonce)
        .expect("Error generating random nonce");
    header.set_nonce(to_hex_string(nonce)); // this `to_hex_string` is simple, just search "convert bytes to hex string" online

    auto input_vec = ["1cf1266e282c41be5e4254d8820772c5518a2c5a8c0c7f7eda19594a7eb539453e1ed7"];
    auto output_vec  = ["1cf1266e282c41be5e4254d8820772c5518a2c5a8c0c7f7eda19594a7eb539453e1ed7"];

    header.set_inputs(RepeatedField::from_vec(input_vec));
    header.set_outputs(RepeatedField::from_vec(output_vec));
    // NOTE: this->get_public_key() is a general function, the logic you can read at the top of Client docs, in the "Signing" part
    header.set_signer_public_key(
            this->get_public_key()
    );
    header.set_batcher_public_key(
            this->get_public_key()
    );

    header.set_payload_sha512(to_hex_string(&sha512(&payload_bytes).to_vec()));

    // Header part done
}
```

Then finally the Transaction object,
```cpp
void AppClient::set(string var_name, int val) {
    // ... till the Header part

    const auto& header_bytes = convert_to_bytes(header);    // Read note in Step#1 abt convert_to_bytes

    const auto& signed_header_bytes = this->sign(header_bytes);

    Transaction transaction;
    transaction.set_header(header_bytes);
    transaction.set_header_signature(signed_header_bytes);
    transaction.set_payload(payload_bytes);
}
```

### 3. Create a `BatchList` from the `Transaction` object

This also, divided into parts
1. Create the `BatchHeader` object
2. Create `Batch` object
3. Create `BatchList` from this single batch object (for now)

```cpp
// Creating BatchHeader
void AppClient::set(string var_name, int val) {
    // ... till the Transaction part

    /* From Docs ->
    * Once the TransactionHeader is constructed, its bytes are then used to create a signature.
    * This header signature also acts as the ID of the transaction
    */
    // same as "transaction_signatures"
    auto transaction_ids = vector<Transaction>({transaction})
        .map([](trx) -> string { return trx.get_header_signature(); });

    BatchHeader batch_header;

    batch_header.set_signer_public_key(
            this->get_public_key()
    );
    batch_header.set_transaction_ids(RepeatedField::from_vec(transaction_ids));

}
```

Now, create the `Batch` and `BatchList`
```cpp
void AppClient::set(string var_name, int val) {
    // ... till the BatchHeader part

    auto batch_header_bytes = convert_to_bytes(batch_header);
    auto signed_batch_header_bytes = this->sign(batch_header_bytes);

    Batch batch;
    batch.set_header(batch_header_bytes);
    batch.set_header_signature(signature);
    batch.set_transactions(RepeatedField::from_vec({transaction});

    BatchList batch_list;
    batch_list.set_batches(RepeatedField::from_vec({batch}}));
    auto batch_list_bytes = convert_to_bytes(batch_list);
}
```

### 4. Send transaction to `_rest-api-url_/batches`

This one is simple, but you may face networking problems
```cpp
void AppClient::set(string var_name, int val) {
    // ... till the BatchList part

    auto batch_list_bytes = convert_to_bytes(batch_list);
    this->send_transaction(batch_list_bytes);
}
```

The send_transaction function is a utility function like this:
```cpp
void AppClient::send_transaction(vector<uint8_t>& bytes) {
    RestClient client;   // a rest client, use wichever library is available for the lanugauage
    client
        .post("http://localhost:8008/batches")
        .header("Content-Type", "application/octet-stream")
        .body(
            batch_list_bytes,
        )
        .send()
}
```

These overall steps are SAME for any language, you will have a client, that can set a variable value by now... Note, for now, it can only just send the batch to validator, no actual change will happen until you have a transaction processor too.
