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

(function(factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['ApiClient', 'A15kInteractions/App', 'A15kInteractions/AppUpdate', 'A15kInteractions/Error', 'A15kInteractions/Flag', 'A15kInteractions/FlagNew', 'A15kInteractions/FlagUpdate', 'A15kInteractions/Presentation', 'A15kInteractions/PresentationResponse', 'A15kInteractions/Rating', 'A15kInteractions/RatingNew', 'api/AppsApi', 'api/FlagsApi', 'api/PresentationsApi', 'api/RatingsApi'], factory);
  } else if (typeof module === 'object' && module.exports) {
    // CommonJS-like environments that support module.exports, like Node.
    module.exports = factory(require('./ApiClient'), require('./A15kInteractions/App'), require('./A15kInteractions/AppUpdate'), require('./A15kInteractions/Error'), require('./A15kInteractions/Flag'), require('./A15kInteractions/FlagNew'), require('./A15kInteractions/FlagUpdate'), require('./A15kInteractions/Presentation'), require('./A15kInteractions/PresentationResponse'), require('./A15kInteractions/Rating'), require('./A15kInteractions/RatingNew'), require('./api/AppsApi'), require('./api/FlagsApi'), require('./api/PresentationsApi'), require('./api/RatingsApi'));
  }
}(function(ApiClient, App, AppUpdate, Error, Flag, FlagNew, FlagUpdate, Presentation, PresentationResponse, Rating, RatingNew, AppsApi, FlagsApi, PresentationsApi, RatingsApi) {
  'use strict';

  /**
   * Records_interactions_with_content_distributed_by_the_Assessment_Network_Requests_to_this_API_should_include_applicationjson_in_the_Accept_header_The_desired_API_version_is_specified_in_the_request_URL_e_g_____a15k_orgv0flags___________While_the_API_does_support_a_default_version_that_version_will_change_over__________time_and_therefore_should_not_be_used_in_production_codeSome_endpoints_require_an_API_key_to_be_passed_in_the_request_header___There_are_two__________types_of_API_keys_API_tokens_and_API_IDs___An_API_token_is_used_for_more_restricted__________access___Such_tokens_should_not_be_shared_with_end_users___API_IDs_are_used_for_less__________restricted_access_and_may_be_exposed_to_clients__e_g__through_use_in_browser_side_code___________Both_keys_are_available_to_members_through_www_a15k_org_.<br>
   * The <code>index</code> module provides access to constructors for all the classes which comprise the public API.
   * <p>
   * An AMD (recommended!) or CommonJS application will generally do something equivalent to the following:
   * <pre>
   * var A15kInteractions = require('index'); // See note below*.
   * var xxxSvc = new A15kInteractions.XxxApi(); // Allocate the API class we're going to use.
   * var yyyModel = new A15kInteractions.Yyy(); // Construct a model instance.
   * yyyModel.someProperty = 'someValue';
   * ...
   * var zzz = xxxSvc.doSomething(yyyModel); // Invoke the service.
   * ...
   * </pre>
   * <em>*NOTE: For a top-level AMD script, use require(['index'], function(){...})
   * and put the application logic within the callback function.</em>
   * </p>
   * <p>
   * A non-AMD browser application (discouraged) might do something like this:
   * <pre>
   * var xxxSvc = new A15kInteractions.XxxApi(); // Allocate the API class we're going to use.
   * var yyy = new A15kInteractions.Yyy(); // Construct a model instance.
   * yyyModel.someProperty = 'someValue';
   * ...
   * var zzz = xxxSvc.doSomething(yyyModel); // Invoke the service.
   * ...
   * </pre>
   * </p>
   * @module index
   * @version 0.1.0
   */
  var exports = {
    /**
     * The ApiClient constructor.
     * @property {module:ApiClient}
     */
    ApiClient: ApiClient,
    /**
     * The App model constructor.
     * @property {module:A15kInteractions/App}
     */
    App: App,
    /**
     * The AppUpdate model constructor.
     * @property {module:A15kInteractions/AppUpdate}
     */
    AppUpdate: AppUpdate,
    /**
     * The Error model constructor.
     * @property {module:A15kInteractions/Error}
     */
    Error: Error,
    /**
     * The Flag model constructor.
     * @property {module:A15kInteractions/Flag}
     */
    Flag: Flag,
    /**
     * The FlagNew model constructor.
     * @property {module:A15kInteractions/FlagNew}
     */
    FlagNew: FlagNew,
    /**
     * The FlagUpdate model constructor.
     * @property {module:A15kInteractions/FlagUpdate}
     */
    FlagUpdate: FlagUpdate,
    /**
     * The Presentation model constructor.
     * @property {module:A15kInteractions/Presentation}
     */
    Presentation: Presentation,
    /**
     * The PresentationResponse model constructor.
     * @property {module:A15kInteractions/PresentationResponse}
     */
    PresentationResponse: PresentationResponse,
    /**
     * The Rating model constructor.
     * @property {module:A15kInteractions/Rating}
     */
    Rating: Rating,
    /**
     * The RatingNew model constructor.
     * @property {module:A15kInteractions/RatingNew}
     */
    RatingNew: RatingNew,
    /**
     * The AppsApi service constructor.
     * @property {module:api/AppsApi}
     */
    AppsApi: AppsApi,
    /**
     * The FlagsApi service constructor.
     * @property {module:api/FlagsApi}
     */
    FlagsApi: FlagsApi,
    /**
     * The PresentationsApi service constructor.
     * @property {module:api/PresentationsApi}
     */
    PresentationsApi: PresentationsApi,
    /**
     * The RatingsApi service constructor.
     * @property {module:api/RatingsApi}
     */
    RatingsApi: RatingsApi
  };

  return exports;
}));
