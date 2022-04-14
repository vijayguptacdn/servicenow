# ServiewNow Assignment

**Open ubuntu terminal in your system and checkout to folder directory**

'```cd ServiceNow```

**Run below command to generate CA certificate**

 ```ruby self_signed_certificate.rb```

**Run web server using command **

 ```ruby server.rb```

**Keep running server on this tab and open new console tab and Run commnad**

 ```ruby client.rb```

 (It will result the ceritifcate expiration date.)


**Now the test server using REST API then hit curl request to console and make sure server is running**
  ```curl --cacert cert.pem https://localhost:2000```


**Run below rake task get result.**
```
rake run:client
rake run:rest_api
```
