# Release History

### 0.25.0 / 2017-05-25

* New Error Reporting instrumentation client.
* Introduce simple `Google::Cloud::ErrorReporting.report` interface to easily report Ruby exception.
* New `Google::Cloud::ErrorReporting.configure` instrumentation configuration interface.
* `Google::Cloud::ErrorReporting::Middleware` can now be used without required parameters.

### 0.24.0 / 2017-03-31

* Automatic retry on `UNAVAILABLE` errors

### 0.23.3 / 2017-03-03

* Update GRPC header value sent to the Error Reporting API.

### 0.23.2 / 2017-03-01

* Update GRPC header value sent to the Error Reporting API.

### 0.23.1 / 2017-02-23

* Add middleware require to rails module (premist)

### 0.23.0 / 2017-02-21

* Fix GRPC retry bug
* The client_config data structure has replaced retry_codes/retry_codes_def with retry_codes
* Update GRPC/Protobuf/GAX dependencies

### 0.22.0 / 2017-01-27

* Update Error Reporting requires. For Rack integration, users now need to use
  `require "google/cloud/error_reporting/middleware"` rather than
  `require "google/cloud/error_reporting/v1beta1"`.
* Change class names in low-level API (GAPIC)

### 0.21.2 / 2016-11-03

* Fixed instrumentation integration with Ruby on Rails

### 0.21.1 / 2016-11-01

* Fixed instrumentation integration with non-Rails Rack frameworks

### 0.21.0 / 2016-10-20

* First release
