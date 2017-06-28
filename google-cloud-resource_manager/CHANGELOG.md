# Release History

### 0.26.0 / 2017-06-27

* Upgrade dependency on Google API Client

### 0.25.0 / 2017-06-01

* Fix apiary client argument case.
* Update gem spec homepage links.
* Remove memoization of Policy.
* Remove force parameter from Project#policy.
* Remove Policy#deep_dup.

### 0.24.1 / 2017-04-06

* Fix error due to missing require.

### 0.24.0 / 2017-04-05

* Upgrade dependency on Google API Client

### 0.23.0 / 2017-03-31

* Updated documentation

### 0.22.0 / 2017-03-03

* Dependency on Google API Client has been updated to 0.10.x.

### 0.21.0 / 2016-10-20

* New service constructor Google::Cloud::ResourceManager.new

### 0.20.1 / 2016-09-02

* Fix for timeout on uploads.

### 0.20.0 / 2016-08-26

This gem contains the Google Cloud Resource Manager service implementation for the `google-cloud` gem. The `google-cloud` gem replaces the old `gcloud` gem. Legacy code can continue to use the `gcloud` gem.

* Namespace is now `Google::Cloud`
* The `google-cloud` gem is now an umbrella package for individual gems
