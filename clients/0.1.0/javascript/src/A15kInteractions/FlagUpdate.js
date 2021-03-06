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
    define(['ApiClient'], factory);
  } else if (typeof module === 'object' && module.exports) {
    // CommonJS-like environments that support module.exports, like Node.
    module.exports = factory(require('../ApiClient'));
  } else {
    // Browser globals (root is window)
    if (!root.A15kInteractions) {
      root.A15kInteractions = {};
    }
    root.A15kInteractions.FlagUpdate = factory(root.A15kInteractions.ApiClient);
  }
}(this, function(ApiClient) {
  'use strict';




  /**
   * The FlagUpdate model module.
   * @module A15kInteractions/FlagUpdate
   * @version 0.1.0
   */

  /**
   * Constructs a new <code>FlagUpdate</code>.
   * @alias module:A15kInteractions/FlagUpdate
   * @class
   */
  var exports = function() {
    var _this = this;



  };

  /**
   * Constructs a <code>FlagUpdate</code> from a plain JavaScript object, optionally creating a new instance.
   * Copies all relevant properties from <code>data</code> to <code>obj</code> if supplied or a new instance if not.
   * @param {Object} data The plain JavaScript object bearing properties of interest.
   * @param {module:A15kInteractions/FlagUpdate} obj Optional instance to populate.
   * @return {module:A15kInteractions/FlagUpdate} The populated <code>FlagUpdate</code> instance.
   */
  exports.constructFromObject = function(data, obj) {
    if (data) {
      obj = obj || new exports();

      if (data.hasOwnProperty('type')) {
        obj['type'] = ApiClient.convertToType(data['type'], 'String');
      }
      if (data.hasOwnProperty('explanation')) {
        obj['explanation'] = ApiClient.convertToType(data['explanation'], 'String');
      }
    }
    return obj;
  }

  /**
   * The type of flag
   * @member {module:A15kInteractions/FlagUpdate.TypeEnum} type
   */
  exports.prototype['type'] = undefined;
  /**
   * The end-user's explanation of why they added this flag.
   * @member {String} explanation
   */
  exports.prototype['explanation'] = undefined;


  /**
   * Allowed values for the <code>type</code> property.
   * @enum {String}
   * @readonly
   */
  exports.TypeEnum = {
    /**
     * value: "unspecified"
     * @const
     */
    "unspecified": "unspecified",
    /**
     * value: "typo"
     * @const
     */
    "typo": "typo",
    /**
     * value: "copyright_violation"
     * @const
     */
    "copyright_violation": "copyright_violation",
    /**
     * value: "incorrect"
     * @const
     */
    "incorrect": "incorrect",
    /**
     * value: "offensive"
     * @const
     */
    "offensive": "offensive"  };


  return exports;
}));


