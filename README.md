Crypt::Keyczar
==============

Keyczar is an open source cryptographic toolkit designed to make it
easier and safer for devlopers to use cryptography in their
applications. Keyczar supports authentication and encryption with
both symmetric and asymmetric keys. Some features of Keyczar include:

 * A simple API

 * Key rotation and versioning

 * Safe default algorithms, modes, and key lengths

 * Automated generation of initialization vectors and ciphertext
   signatures

 * Perl, Java, Python, and C++ implementations

SUPPORTED CRYPTOGRAPHIC ALGORITHMS(current version)
---------------------------------------------------
* HMAC
   Default keys are 256 bits. SHA1 used as the hash algorithm.
   HMAC-SHA224, HMAC-SHA256, HMAC-SHA384 and HMAC-SHA512
   algorithms are also supported.

* AES
   Default keys are 128 bits. 192 and 256 bit keys are also
   supported. CBC mode with PKCS#5 padding is used by default.

* RSA Encryption
   RSA-OAEP encryption is used. Default key size is 2048 bits.
   1024, 768, and 512 bit keys are also supported.

* RSA Signatures
   RSA-SHA1 signing is used. Default key size is 2048 bits.
   1024, 768, and 512 bit keys are also supported.

* DSA
    DSA-SHA1 signing algorithm used by default. Default key
    size is 1024 bits.

DEPENDENCIES
------------
This module requires these other modules and libraries:

  libcrypto (OpenSSL 0.9.8 or later)
  MIME::Base64
  JSON (version 1.xxx or 2.xxx)

USE CASE
--------

FME service called **webadmin** uses this module to encrypt data.
Every new environment (single or multi tenant) needs a new key.

PREREQUISITES
-------------

- S3 bucket created.
- S3 actions allowed in the IAM policy for webadmin.

CREATE KEYS
-----------
```bash
# Build the container (Dependencies are too old to be used locally)
docker build --platform linux/amd64 -t keyczar .

# Execute script (will run within the container)
./keyczar.sh create --location=/home/ubuntu/secrets-keyczar --purpose=crypt --name=split --type=AES
./keyczar.sh addkey --location=/home/ubuntu/secrets-keyczar --size=256
./keyczar.sh addkey --location=/home/ubuntu/secrets-keyczar --status=primary --size=256

# Upload files to S3 while keeping the folder structure
aws --profile $PROFILE --region $REGION s3 cp secrets-keyczar/ s3://$SECRETS_BUCKET/secrets-keyczar/ --recursive
```

SEE ALSO
--------
  "keyczar" in bin,
  perldoc Crypt::Keyczar,
  perldoc Crypt::Keyczar::Crypter,
  perldoc Crypt::Keyczar::Signer,
  http://www.keyczar.org/
