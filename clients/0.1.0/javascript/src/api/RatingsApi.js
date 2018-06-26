/**
 * Assessment Network Interactions API
 * Records interactions with content distributed by the Assessment Network.  Requests to this API should include `application/json` in the `Accept` header.  The desired API version is specified in the request URL, e.g. `...a15k.org/v0/flags`.          While the API does support a default version, that version will change over          time and therefore should not be used in production code!  Some endpoints require an API key to be passed in the request header.  There are two          types of API keys: API tokens and API IDs.  An API token is used for more restricted          access.  Such tokens should not be shared with end users.  API IDs are used for less          restricted access and may be exposed to clients (e.g. through use in browser-side code).          Both keys are available to members through www.a15k.org. 
 *
 * OpenAPI spec version: 0.1.0
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 *
 * Swagger Codegen version: 2.3.1
 *
 * Do not edit the class manually.
 *
 */

(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['ApiClient', 'A15kInteractions/Error', 'A15kInteractions/Flag', 'A15kInteractions/Rating', 'A15kInteractions/RatingNew'], factory);
  } else if (typeof module === 'object' && module.exports) {
    // CommonJS-like environments that support module.exports, like Node.
    module.exports = factory(require('../ApiClient'), require('../A15kInteractions/Error'), require('../A15kInteractions/Flag'), require('../A15kInteractions/Rating'), require('../A15kInteractions/RatingNew'));
  } else {
    // Browser globals (root is window)
    if (!root.A15kInteractions) {
      root.A15kInteractions = {};
    }
    root.A15kInteractions.RatingsApi = factory(root.A15kInteractions.ApiClient, root.A15kInteractions.Error, root.A15kInteractions.Flag, root.A15kInteractions.Rating, root.A15kInteractions.RatingNew);
  }
}(this, function(ApiClient, Error, Flag, Rating, RatingNew) {
  'use strict';

  /**
   * Ratings service.
   * @module api/RatingsApi
   * @version 0.1.0
   */

  /**
   * Constructs a new RatingsApi. 
   * @alias module:api/RatingsApi
   * @class
   * @param {module:ApiClient} [apiClient] Optional API client implementation to use,
   * default to {@link module:ApiClient#instance} if unspecified.
   */
  var exports = function(apiClient) {
    this.apiClient = apiClient || ApiClient.instance;



    /**
     * Rate some content
     * Rates some content for some user in some app.  New ratings replace old ratings.
     * @param {module:A15kInteractions/RatingNew} rating The rating data
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with an object containing data of type {@link module:A15kInteractions/Rating} and HTTP response
     */
    this.createRatingWithHttpInfo = function(rating) {
      var postBody = rating;

      // verify the required parameter 'rating' is set
      if (rating === undefined || rating === null) {
        throw new Error("Missing the required parameter 'rating' when calling createRating");
      }


      var pathParams = {
      };
      var queryParams = {
      };
      var collectionQueryParams = {
      };
      var headerParams = {
      };
      var formParams = {
      };

      var authNames = ['api_id'];
      var contentTypes = ['application/json'];
      var accepts = ['application/json'];
      var returnType = Rating;

      return this.apiClient.callApi(
        '/ratings', 'POST',
        pathParams, queryParams, collectionQueryParams, headerParams, formParams, postBody,
        authNames, contentTypes, accepts, returnType
      );
    }

    /**
     * Rate some content
     * Rates some content for some user in some app.  New ratings replace old ratings.
     * @param {module:A15kInteractions/RatingNew} rating The rating data
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with data of type {@link module:A15kInteractions/Rating}
     */
    this.createRating = function(rating) {
      return this.createRatingWithHttpInfo(rating)
        .then(function(response_and_data) {
          return response_and_data.data;
        });
    }


    /**
     * Delete a rating
     * Delete a rating.  Anyone with the rating ID (very hard to guess) can delete it.
     * @param {String} id ID of the rating to delete
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with an object containing data of type {@link module:A15kInteractions/Flag} and HTTP response
     */
    this.deleteRatingWithHttpInfo = function(id) {
      var postBody = null;

      // verify the required parameter 'id' is set
      if (id === undefined || id === null) {
        throw new Error("Missing the required parameter 'id' when calling deleteRating");
      }


      var pathParams = {
        'id': id
      };
      var queryParams = {
      };
      var collectionQueryParams = {
      };
      var headerParams = {
      };
      var formParams = {
      };

      var authNames = ['api_id'];
      var contentTypes = ['application/json'];
      var accepts = ['application/json'];
      var returnType = Flag;

      return this.apiClient.callApi(
        '/ratings/{id}', 'DELETE',
        pathParams, queryParams, collectionQueryParams, headerParams, formParams, postBody,
        authNames, contentTypes, accepts, returnType
      );
    }

    /**
     * Delete a rating
     * Delete a rating.  Anyone with the rating ID (very hard to guess) can delete it.
     * @param {String} id ID of the rating to delete
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with data of type {@link module:A15kInteractions/Flag}
     */
    this.deleteRating = function(id) {
      return this.deleteRatingWithHttpInfo(id)
        .then(function(response_and_data) {
          return response_and_data.data;
        });
    }


    /**
     * Retrieve a rating
     * Retrieve a rating.  Anyone with the rating ID (very hard to guess) can retrieve it.
     * @param {String} id ID of the rating to retrieve
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with an object containing data of type {@link module:A15kInteractions/Rating} and HTTP response
     */
    this.getRatingWithHttpInfo = function(id) {
      var postBody = null;

      // verify the required parameter 'id' is set
      if (id === undefined || id === null) {
        throw new Error("Missing the required parameter 'id' when calling getRating");
      }


      var pathParams = {
        'id': id
      };
      var queryParams = {
      };
      var collectionQueryParams = {
      };
      var headerParams = {
      };
      var formParams = {
      };

      var authNames = ['api_id'];
      var contentTypes = ['application/json'];
      var accepts = ['application/json'];
      var returnType = Rating;

      return this.apiClient.callApi(
        '/ratings/{id}', 'GET',
        pathParams, queryParams, collectionQueryParams, headerParams, formParams, postBody,
        authNames, contentTypes, accepts, returnType
      );
    }

    /**
     * Retrieve a rating
     * Retrieve a rating.  Anyone with the rating ID (very hard to guess) can retrieve it.
     * @param {String} id ID of the rating to retrieve
     * @return {Promise} a {@link https://www.promisejs.org/|Promise}, with data of type {@link module:A15kInteractions/Rating}
     */
    this.getRating = function(id) {
      return this.getRatingWithHttpInfo(id)
        .then(function(response_and_data) {
          return response_and_data.data;
        });
    }
  };

  return exports;
}));