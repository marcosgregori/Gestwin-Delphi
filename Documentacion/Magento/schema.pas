{ ***************************************************************************  
  sgcOpenAPI component                                                         
                                                                               
  written by eSeGeCe                                                           
  copyright © 2023                                                             
  Email : info@esegece.com                                                     
  Web : http://www.esegece.com                                                 
  *************************************************************************** }

unit schema;

interface

{$IF DEFINED(VER280) OR DEFINED(VER290) OR DEFINED(VER300) OR DEFINED(VER310) OR DEFINED(VER320) OR DEFINED(VER330) OR DEFINED(VER340) OR DEFINED(VER350)}
{$DEFINE SGC_OPENAPI_JSON}
{$IFEND}
uses
  Classes, SysUtils, 
  sgcHTTP_OpenAPI_Client;

Type


{$IFDEF SGC_OPENAPI_JSON}
TsgcOpenAPI_error_response_Class = class;
TsgcOpenAPI_error_errors_item_Class = class;
TsgcOpenAPI_error_parameters_item_Class = class;
TsgcOpenAPI_directory_data_currency_information_interface_Class = class;
TsgcOpenAPI_directory_data_exchange_rate_interface_Class = class;
TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class = class;
TsgcOpenAPI_directory_data_currency_information_extension_interface_Class = class;
TsgcOpenAPI_directory_data_country_information_interface_Class = class;
TsgcOpenAPI_directory_data_region_information_interface_Class = class;
TsgcOpenAPI_directory_data_region_information_extension_interface_Class = class;
TsgcOpenAPI_directory_data_country_information_extension_interface_Class = class;
TsgcOpenAPI_customer_data_customer_interface_Class = class;
TsgcOpenAPI_customer_data_address_interface_Class = class;
TsgcOpenAPI_customer_data_region_interface_Class = class;
TsgcOpenAPI_customer_data_region_extension_interface_Class = class;
TsgcOpenAPI_customer_data_address_extension_interface_Class = class;
TsgcOpenAPI_framework_attribute_interface_Class = class;
TsgcOpenAPI_customer_data_customer_extension_interface_Class = class;
TsgcOpenAPI_framework_search_search_result_interface_Class = class;
TsgcOpenAPI_framework_search_document_interface_Class = class;
TsgcOpenAPI_framework_search_aggregation_interface_Class = class;
TsgcOpenAPI_framework_search_bucket_interface_Class = class;
TsgcOpenAPI_framework_search_aggregation_value_interface_Class = class;
TsgcOpenAPI_framework_search_search_criteria_interface_Class = class;
TsgcOpenAPI_framework_search_filter_group_Class = class;
TsgcOpenAPI_framework_filter_Class = class;
TsgcOpenAPI_framework_sort_order_Class = class;
TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_button_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class = class;
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class = class;
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class = class;
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class = class;
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_image_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class = class;
TsgcOpenAPI_catalog_data_product_render_extension_interface_Class = class;
TsgcOpenAPI_quote_data_cart_interface_Class = class;
TsgcOpenAPI_quote_data_cart_item_interface_Class = class;
TsgcOpenAPI_quote_data_product_option_interface_Class = class;
TsgcOpenAPI_quote_data_product_option_extension_interface_Class = class;
TsgcOpenAPI_catalog_data_custom_option_interface_Class = class;
TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class = class;
TsgcOpenAPI_framework_data_image_content_interface_Class = class;
TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class = class;
TsgcOpenAPI_bundle_data_bundle_option_interface_Class = class;
TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class = class;
TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class = class;
TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class = class;
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class = class;
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class = class;
TsgcOpenAPI_quote_data_cart_item_extension_interface_Class = class;
TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class = class;
TsgcOpenAPI_sales_rule_data_discount_data_interface_Class = class;
TsgcOpenAPI_quote_data_address_interface_Class = class;
TsgcOpenAPI_quote_data_address_extension_interface_Class = class;
TsgcOpenAPI_quote_data_currency_interface_Class = class;
TsgcOpenAPI_quote_data_currency_extension_interface_Class = class;
TsgcOpenAPI_quote_data_cart_extension_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_assignment_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_extension_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class = class;
TsgcOpenAPI_quote_data_payment_interface_Class = class;
TsgcOpenAPI_quote_data_payment_extension_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_method_interface_Class = class;
TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class = class;
TsgcOpenAPI_quote_data_payment_method_interface_Class = class;
TsgcOpenAPI_quote_data_totals_additional_data_interface_Class = class;
TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class = class;
TsgcOpenAPI_gift_message_data_message_interface_Class = class;
TsgcOpenAPI_gift_message_data_message_extension_interface_Class = class;
TsgcOpenAPI_quote_data_totals_interface_Class = class;
TsgcOpenAPI_quote_data_totals_item_interface_Class = class;
TsgcOpenAPI_quote_data_totals_item_extension_interface_Class = class;
TsgcOpenAPI_quote_data_total_segment_interface_Class = class;
TsgcOpenAPI_quote_data_total_segment_extension_interface_Class = class;
TsgcOpenAPI_tax_data_grand_total_details_interface_Class = class;
TsgcOpenAPI_tax_data_grand_total_rates_interface_Class = class;
TsgcOpenAPI_quote_data_totals_extension_interface_Class = class;
TsgcOpenAPI_checkout_data_shipping_information_interface_Class = class;
TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class = class;
TsgcOpenAPI_checkout_data_payment_details_interface_Class = class;
TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class = class;
TsgcOpenAPI_checkout_data_totals_information_interface_Class = class;
TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class = class;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class = class;
TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class = class;
TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class = class;
TsgcOpenAPI_GetV1DirectoryCurrency_Response = class;
TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response = class;
TsgcOpenAPI_PostV1Customers_Response = class;
TsgcOpenAPI_GetV1Search_Response = class;
TsgcOpenAPI_GetV1Productsrenderinfo_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartId_Response = class;
TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response = class;
TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response = class;
TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response = class;
TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response = class;
TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response = class;
TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response = class;
TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response = class;
TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response = class;
TsgcOpenAPI_GetV1ApplepayAuth_Response = class;
TsgcOpenAPI_error_errors_Array = class;
TsgcOpenAPI_error_parameters_Array = class;
{$ELSE}
TsgcOpenAPI_error_response_Class = string;
TsgcOpenAPI_error_errors_item_Class = string;
TsgcOpenAPI_error_parameters_item_Class = string;
TsgcOpenAPI_directory_data_currency_information_interface_Class = string;
TsgcOpenAPI_directory_data_exchange_rate_interface_Class = string;
TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class = string;
TsgcOpenAPI_directory_data_currency_information_extension_interface_Class = string;
TsgcOpenAPI_directory_data_country_information_interface_Class = string;
TsgcOpenAPI_directory_data_region_information_interface_Class = string;
TsgcOpenAPI_directory_data_region_information_extension_interface_Class = string;
TsgcOpenAPI_directory_data_country_information_extension_interface_Class = string;
TsgcOpenAPI_customer_data_customer_interface_Class = string;
TsgcOpenAPI_customer_data_address_interface_Class = string;
TsgcOpenAPI_customer_data_region_interface_Class = string;
TsgcOpenAPI_customer_data_region_extension_interface_Class = string;
TsgcOpenAPI_customer_data_address_extension_interface_Class = string;
TsgcOpenAPI_framework_attribute_interface_Class = string;
TsgcOpenAPI_customer_data_customer_extension_interface_Class = string;
TsgcOpenAPI_framework_search_search_result_interface_Class = string;
TsgcOpenAPI_framework_search_document_interface_Class = string;
TsgcOpenAPI_framework_search_aggregation_interface_Class = string;
TsgcOpenAPI_framework_search_bucket_interface_Class = string;
TsgcOpenAPI_framework_search_aggregation_value_interface_Class = string;
TsgcOpenAPI_framework_search_search_criteria_interface_Class = string;
TsgcOpenAPI_framework_search_filter_group_Class = string;
TsgcOpenAPI_framework_filter_Class = string;
TsgcOpenAPI_framework_sort_order_Class = string;
TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_button_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class = string;
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class = string;
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class = string;
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class = string;
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_image_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class = string;
TsgcOpenAPI_catalog_data_product_render_extension_interface_Class = string;
TsgcOpenAPI_quote_data_cart_interface_Class = string;
TsgcOpenAPI_quote_data_cart_item_interface_Class = string;
TsgcOpenAPI_quote_data_product_option_interface_Class = string;
TsgcOpenAPI_quote_data_product_option_extension_interface_Class = string;
TsgcOpenAPI_catalog_data_custom_option_interface_Class = string;
TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class = string;
TsgcOpenAPI_framework_data_image_content_interface_Class = string;
TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class = string;
TsgcOpenAPI_bundle_data_bundle_option_interface_Class = string;
TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class = string;
TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class = string;
TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class = string;
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class = string;
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class = string;
TsgcOpenAPI_quote_data_cart_item_extension_interface_Class = string;
TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class = string;
TsgcOpenAPI_sales_rule_data_discount_data_interface_Class = string;
TsgcOpenAPI_quote_data_address_interface_Class = string;
TsgcOpenAPI_quote_data_address_extension_interface_Class = string;
TsgcOpenAPI_quote_data_currency_interface_Class = string;
TsgcOpenAPI_quote_data_currency_extension_interface_Class = string;
TsgcOpenAPI_quote_data_cart_extension_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_assignment_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_extension_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class = string;
TsgcOpenAPI_quote_data_payment_interface_Class = string;
TsgcOpenAPI_quote_data_payment_extension_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_method_interface_Class = string;
TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class = string;
TsgcOpenAPI_quote_data_payment_method_interface_Class = string;
TsgcOpenAPI_quote_data_totals_additional_data_interface_Class = string;
TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class = string;
TsgcOpenAPI_gift_message_data_message_interface_Class = string;
TsgcOpenAPI_gift_message_data_message_extension_interface_Class = string;
TsgcOpenAPI_quote_data_totals_interface_Class = string;
TsgcOpenAPI_quote_data_totals_item_interface_Class = string;
TsgcOpenAPI_quote_data_totals_item_extension_interface_Class = string;
TsgcOpenAPI_quote_data_total_segment_interface_Class = string;
TsgcOpenAPI_quote_data_total_segment_extension_interface_Class = string;
TsgcOpenAPI_tax_data_grand_total_details_interface_Class = string;
TsgcOpenAPI_tax_data_grand_total_rates_interface_Class = string;
TsgcOpenAPI_quote_data_totals_extension_interface_Class = string;
TsgcOpenAPI_checkout_data_shipping_information_interface_Class = string;
TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class = string;
TsgcOpenAPI_checkout_data_payment_details_interface_Class = string;
TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class = string;
TsgcOpenAPI_checkout_data_totals_information_interface_Class = string;
TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class = string;
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class = string;
TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class = string;
TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class = string;
TsgcOpenAPI_GetV1DirectoryCurrency_Response = string;
TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response = string;
TsgcOpenAPI_PostV1Customers_Response = string;
TsgcOpenAPI_GetV1Search_Response = string;
TsgcOpenAPI_GetV1Productsrenderinfo_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartId_Response = string;
TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response = string;
TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response = string;
TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response = string;
TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response = string;
TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response = string;
TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response = string;
TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response = string;
TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response = string;
TsgcOpenAPI_GetV1ApplepayAuth_Response = string;
TsgcOpenAPI_error_errors_Array = string;
TsgcOpenAPI_error_parameters_Array = string;
{$ENDIF}
sgcOpenAPI_schema = class(TsgcOpenAPI_Client)
protected
// directoryCurrencyInformationAcquirerV1
  function _GetV1DirectoryCurrency(const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// directoryCountryInformationAcquirerV1
  function _GetV1DirectoryCountries(const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _GetV1DirectoryCountriesCountryId(aCountryId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// customerAccountManagementV1
  function _PostV1Customers(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken: string; aCustomerId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PutV1CustomersPassword(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1CustomersResetPassword(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1CustomersIsEmailAvailable(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// searchV1
  function _GetV1Search(aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aSearchCriteriarequestName: string = ''; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// catalogProductRenderListV1
  function _GetV1Productsrenderinfo(aCurrencyCode: string; aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aStoreId: Int64 = 0; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCartRepositoryV1
  function _GetV1GuestcartsCartId(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCartManagementV1
  function _PostV1Guestcarts(const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PutV1GuestcartsCartIdOrder(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestShippingMethodManagementV1
  function _GetV1GuestcartsCartIdShippingmethods(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestShipmentEstimationV1
  function _PostV1GuestcartsCartIdEstimateshippingmethods(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCartItemRepositoryV1
  function _GetV1GuestcartsCartIdItems(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdItems(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PutV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _DeleteV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestPaymentMethodManagementV1
  function _GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _GetV1GuestcartsCartIdPaymentmethods(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestBillingAddressManagementV1
  function _GetV1GuestcartsCartIdBillingaddress(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdBillingaddress(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCouponManagementV1
  function _GetV1GuestcartsCartIdCoupons(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _DeleteV1GuestcartsCartIdCoupons(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PutV1GuestcartsCartIdCouponsCouponCode(aCartId: string; aCouponCode: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCartTotalManagementV1
  function _PutV1GuestcartsCartIdCollecttotals(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// quoteGuestCartTotalRepositoryV1
  function _GetV1GuestcartsCartIdTotals(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// integrationAdminTokenServiceV1
  function _PostV1IntegrationAdminToken(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// integrationCustomerTokenServiceV1
  function _PostV1IntegrationCustomerToken(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// checkoutGuestShippingInformationManagementV1
  function _PostV1GuestcartsCartIdShippinginformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// checkoutGuestTotalsInformationManagementV1
  function _PostV1GuestcartsCartIdTotalsinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// checkoutGuestPaymentInformationManagementV1
  function _GetV1GuestcartsCartIdPaymentinformation(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdPaymentinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdSetpaymentinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// giftMessageGuestCartRepositoryV1
  function _GetV1GuestcartsCartIdGiftmessage(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdGiftmessage(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// giftMessageGuestItemRepositoryV1
  function _GetV1GuestcartsCartIdGiftmessageItemId(aCartId: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
  function _PostV1GuestcartsCartIdGiftmessageItemId(aCartId: string; const aBody: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// inventoryInStorePickupApiGetPickupLocationsV1
  function _GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius: Int64 = 0; aSearchRequestpageSize: Int64 = 0; aSearchRequestcurrentPage: Int64 = 0; aSearchRequestareasearchTerm: string = ''; aSearchRequestfilterscountryvalue: string = ''; aSearchRequestfilterscountryconditionType: string = ''; aSearchRequestfilterspostcodevalue: string = ''; aSearchRequestfilterspostcodeconditionType: string = ''; aSearchRequestfiltersregionvalue: string = ''; aSearchRequestfiltersregionconditionType: string = ''; aSearchRequestfiltersregionIdvalue: string = ''; aSearchRequestfiltersregionIdconditionType: string = ''; aSearchRequestfilterscityvalue: string = ''; aSearchRequestfilterscityconditionType: string = ''; aSearchRequestfiltersstreetvalue: string = ''; aSearchRequestfiltersstreetconditionType: string = ''; aSearchRequestfiltersnamevalue: string = ''; aSearchRequestfiltersnameconditionType: string = ''
; aSearchRequestfilterspickupLocationCodevalue: string = ''; aSearchRequestfilterspickupLocationCodeconditionType: string = ''; aSearchRequestscopeType: string = ''; aSearchRequestscopeCode: string = ''; aSearchRequestsort0field: string = ''; aSearchRequestsort0direction: string = ''; aSearchRequestextensionAttributesproductsInfo0sku: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// gestwinOrderCommentGuestOrderCommentManagementV1
  function _PutV1GuestcartsCartIdSetordercomment(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// gestwinSmtpCheckoutManagementV1
  function _PostV1CartsCartIdUpdateorder(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
// payPalBraintreeAuthV1
  function _GetV1ApplepayAuth(const aResponse: TsgcOpenAPIResponse = nil): string; virtual;
public
  constructor Create(aOwner: TComponent); override;
public
  procedure SetServer0();
public
// directoryCurrencyInformationAcquirerV1
  function GetV1DirectoryCurrency(): TsgcOpenAPI_GetV1DirectoryCurrency_Response;
// directoryCountryInformationAcquirerV1
  function GetV1DirectoryCountries(): string;
  function GetV1DirectoryCountriesCountryId(aCountryId: string): TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response;
// customerAccountManagementV1
  function PostV1Customers(const aBody: string): TsgcOpenAPI_PostV1Customers_Response;
  function GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken: string; aCustomerId: Int64 = 0): string;
  function PutV1CustomersPassword(const aBody: string): string;
  function PostV1CustomersResetPassword(const aBody: string): string;
  function PostV1CustomersIsEmailAvailable(const aBody: string): string;
// searchV1
  function GetV1Search(aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aSearchCriteriarequestName: string = ''; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''): TsgcOpenAPI_GetV1Search_Response;
// catalogProductRenderListV1
  function GetV1Productsrenderinfo(aCurrencyCode: string; aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aStoreId: Int64 = 0; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''): TsgcOpenAPI_GetV1Productsrenderinfo_Response;
// quoteGuestCartRepositoryV1
  function GetV1GuestcartsCartId(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartId_Response;
// quoteGuestCartManagementV1
  function PostV1Guestcarts(): string;
  function PutV1GuestcartsCartIdOrder(aCartId: string; const aBody: string): string;
// quoteGuestShippingMethodManagementV1
  function GetV1GuestcartsCartIdShippingmethods(aCartId: string): string;
// quoteGuestShipmentEstimationV1
  function PostV1GuestcartsCartIdEstimateshippingmethods(aCartId: string; const aBody: string): string;
// quoteGuestCartItemRepositoryV1
  function GetV1GuestcartsCartIdItems(aCartId: string): string;
  function PostV1GuestcartsCartIdItems(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response;
  function PutV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response;
  function DeleteV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: Int64 = 0): string;
// quoteGuestPaymentMethodManagementV1
  function GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response;
  function PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aBody: string): string;
  function GetV1GuestcartsCartIdPaymentmethods(aCartId: string): string;
// quoteGuestBillingAddressManagementV1
  function GetV1GuestcartsCartIdBillingaddress(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response;
  function PostV1GuestcartsCartIdBillingaddress(aCartId: string; const aBody: string): string;
// quoteGuestCouponManagementV1
  function GetV1GuestcartsCartIdCoupons(aCartId: string): string;
  function DeleteV1GuestcartsCartIdCoupons(aCartId: string): string;
  function PutV1GuestcartsCartIdCouponsCouponCode(aCartId: string; aCouponCode: string): string;
// quoteGuestCartTotalManagementV1
  function PutV1GuestcartsCartIdCollecttotals(aCartId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response;
// quoteGuestCartTotalRepositoryV1
  function GetV1GuestcartsCartIdTotals(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response;
// integrationAdminTokenServiceV1
  function PostV1IntegrationAdminToken(const aBody: string): string;
// integrationCustomerTokenServiceV1
  function PostV1IntegrationCustomerToken(const aBody: string): string;
// checkoutGuestShippingInformationManagementV1
  function PostV1GuestcartsCartIdShippinginformation(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response;
// checkoutGuestTotalsInformationManagementV1
  function PostV1GuestcartsCartIdTotalsinformation(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response;
// checkoutGuestPaymentInformationManagementV1
  function GetV1GuestcartsCartIdPaymentinformation(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response;
  function PostV1GuestcartsCartIdPaymentinformation(aCartId: string; const aBody: string): string;
  function PostV1GuestcartsCartIdSetpaymentinformation(aCartId: string; const aBody: string): string;
// giftMessageGuestCartRepositoryV1
  function GetV1GuestcartsCartIdGiftmessage(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response;
  function PostV1GuestcartsCartIdGiftmessage(aCartId: string; const aBody: string): string;
// giftMessageGuestItemRepositoryV1
  function GetV1GuestcartsCartIdGiftmessageItemId(aCartId: string; aItemId: Int64 = 0): TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response;
  function PostV1GuestcartsCartIdGiftmessageItemId(aCartId: string; const aBody: string; aItemId: Int64 = 0): string;
// inventoryInStorePickupApiGetPickupLocationsV1
  function GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius: Int64 = 0; aSearchRequestpageSize: Int64 = 0; aSearchRequestcurrentPage: Int64 = 0; aSearchRequestareasearchTerm: string = ''; aSearchRequestfilterscountryvalue: string = ''; aSearchRequestfilterscountryconditionType: string = ''; aSearchRequestfilterspostcodevalue: string = ''; aSearchRequestfilterspostcodeconditionType: string = ''; aSearchRequestfiltersregionvalue: string = ''; aSearchRequestfiltersregionconditionType: string = ''; aSearchRequestfiltersregionIdvalue: string = ''; aSearchRequestfiltersregionIdconditionType: string = ''; aSearchRequestfilterscityvalue: string = ''; aSearchRequestfilterscityconditionType: string = ''; aSearchRequestfiltersstreetvalue: string = ''; aSearchRequestfiltersstreetconditionType: string = ''; aSearchRequestfiltersnamevalue: string = ''; aSearchRequestfiltersnameconditionType: string = ''
; aSearchRequestfilterspickupLocationCodevalue: string = ''; aSearchRequestfilterspickupLocationCodeconditionType: string = ''; aSearchRequestscopeType: string = ''; aSearchRequestscopeCode: string = ''; aSearchRequestsort0field: string = ''; aSearchRequestsort0direction: string = ''; aSearchRequestextensionAttributesproductsInfo0sku: string = ''): TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response;
// gestwinOrderCommentGuestOrderCommentManagementV1
  function PutV1GuestcartsCartIdSetordercomment(aCartId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response;
// gestwinSmtpCheckoutManagementV1
  function PostV1CartsCartIdUpdateorder(aCartId: string; const aBody: string): string;
// payPalBraintreeAuthV1
  function GetV1ApplepayAuth(): TsgcOpenAPI_GetV1ApplepayAuth_Response;
end;

{$IFDEF SGC_OPENAPI_JSON}
TsgcOpenAPI_error_response_Class = class(TsgcOpenAPIClass)
private
  Fmessage: String;
  Ferrors: TArray<TsgcOpenAPI_error_errors_item_Class>;
  Fcode: Int64;
  Fparameters: TArray<TsgcOpenAPI_error_parameters_item_Class>;
  Ftrace: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_error_response_Class;
public
//Error message
  property _message: String read Fmessage write Fmessage;
  property Errors: TArray<TsgcOpenAPI_error_errors_item_Class> read Ferrors write Ferrors;
//Error code
  property Code: Int64 read Fcode write Fcode;
  property Parameters: TArray<TsgcOpenAPI_error_parameters_item_Class> read Fparameters write Fparameters;
//Stack trace
  property Trace: String read Ftrace write Ftrace;
end;


//Description
//Error details
TsgcOpenAPI_error_errors_item_Class = class(TsgcOpenAPIClass)
private
  Fmessage: String;
  Fparameters: TArray<TsgcOpenAPI_error_parameters_item_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_error_errors_item_Class;
public
//Error message
  property _message: String read Fmessage write Fmessage;
  property Parameters: TArray<TsgcOpenAPI_error_parameters_item_Class> read Fparameters write Fparameters;
end;


//Description
//Error parameters item
TsgcOpenAPI_error_parameters_item_Class = class(TsgcOpenAPIClass)
private
  Fresources: String;
  FfieldName: String;
  FfieldValue: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_error_parameters_item_Class;
public
//ACL resource
  property Resources: String read Fresources write Fresources;
//Missing or invalid field name
  property FieldName: String read FfieldName write FfieldName;
//Incorrect field value
  property FieldValue: String read FfieldValue write FfieldValue;
end;


//Description
//Currency Information interface.
TsgcOpenAPI_directory_data_currency_information_interface_Class = class(TsgcOpenAPIClass)
private
  Fbase_currency_code: String;
  Fbase_currency_symbol: String;
  Fdefault_display_currency_code: String;
  Fdefault_display_currency_symbol: String;
  Favailable_currency_codes: TArray<string>;
  Fexchange_rates: TArray<TsgcOpenAPI_directory_data_exchange_rate_interface_Class>;
  Fextension_attributes: TsgcOpenAPI_directory_data_currency_information_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_currency_information_interface_Class;
public
//The base currency code for the store.
  property Base_currency_code: String read Fbase_currency_code write Fbase_currency_code;
//The currency symbol of the base currency for the store.
  property Base_currency_symbol: String read Fbase_currency_symbol write Fbase_currency_symbol;
//The default display currency code for the store.
  property Default_display_currency_code: String read Fdefault_display_currency_code write Fdefault_display_currency_code;
//The currency symbol of the default display currency for the store.
  property Default_display_currency_symbol: String read Fdefault_display_currency_symbol write Fdefault_display_currency_symbol;
//The list of allowed currency codes for the store.
  property Available_currency_codes: TArray<string> read Favailable_currency_codes write Favailable_currency_codes;
//The list of exchange rate information for the store.
  property Exchange_rates: TArray<TsgcOpenAPI_directory_data_exchange_rate_interface_Class> read Fexchange_rates write Fexchange_rates;
  property Extension_attributes: TsgcOpenAPI_directory_data_currency_information_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Exchange Rate interface.
TsgcOpenAPI_directory_data_exchange_rate_interface_Class = class(TsgcOpenAPIClass)
private
  Fcurrency_to: String;
  Frate: Extended;
  Fextension_attributes: TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_exchange_rate_interface_Class;
public
//The currency code associated with the exchange rate.
  property Currency_to: String read Fcurrency_to write Fcurrency_to;
//The exchange rate for the associated currency and the store's base currency.
  property Rate: Extended read Frate write Frate;
  property Extension_attributes: TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Directory\Api\Data\ExchangeRateInterface
TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Directory\Api\Data\CurrencyInformationInterface
TsgcOpenAPI_directory_data_currency_information_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_currency_information_extension_interface_Class;
end;


//Description
//Country Information interface.
TsgcOpenAPI_directory_data_country_information_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: String;
  Ftwo_letter_abbreviation: String;
  Fthree_letter_abbreviation: String;
  Ffull_name_locale: String;
  Ffull_name_english: String;
  Favailable_regions: TArray<TsgcOpenAPI_directory_data_region_information_interface_Class>;
  Fextension_attributes: TsgcOpenAPI_directory_data_country_information_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_country_information_interface_Class;
public
//The country id for the store.
  property Id: String read Fid write Fid;
//The country 2 letter abbreviation for the store.
  property Two_letter_abbreviation: String read Ftwo_letter_abbreviation write Ftwo_letter_abbreviation;
//The country 3 letter abbreviation for the store.
  property Three_letter_abbreviation: String read Fthree_letter_abbreviation write Fthree_letter_abbreviation;
//The country full name (in store locale) for the store.
  property Full_name_locale: String read Ffull_name_locale write Ffull_name_locale;
//The country full name (in English) for the store.
  property Full_name_english: String read Ffull_name_english write Ffull_name_english;
//The available regions for the store.
  property Available_regions: TArray<TsgcOpenAPI_directory_data_region_information_interface_Class> read Favailable_regions write Favailable_regions;
  property Extension_attributes: TsgcOpenAPI_directory_data_country_information_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Region Information interface.
TsgcOpenAPI_directory_data_region_information_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: String;
  Fcode: String;
  Fname: String;
  Fextension_attributes: TsgcOpenAPI_directory_data_region_information_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_region_information_interface_Class;
public
//Region id
  property Id: String read Fid write Fid;
//Region code
  property Code: String read Fcode write Fcode;
//Region name
  property Name: String read Fname write Fname;
  property Extension_attributes: TsgcOpenAPI_directory_data_region_information_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Directory\Api\Data\RegionInformationInterface
TsgcOpenAPI_directory_data_region_information_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_region_information_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Directory\Api\Data\CountryInformationInterface
TsgcOpenAPI_directory_data_country_information_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_directory_data_country_information_extension_interface_Class;
end;


//Description
//Customer entity interface for API handling.
TsgcOpenAPI_customer_data_customer_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fgroup_id: Int64;
  Fdefault_billing: String;
  Fdefault_shipping: String;
  Fconfirmation: String;
  Fcreated_at: String;
  Fupdated_at: String;
  Fcreated_in: String;
  Fdob: String;
  Femail: String;
  Ffirstname: String;
  Flastname: String;
  Fmiddlename: String;
  Fprefix: String;
  Fsuffix: String;
  Fgender: Int64;
  Fstore_id: Int64;
  Ftaxvat: String;
  Fwebsite_id: Int64;
  Faddresses: TArray<TsgcOpenAPI_customer_data_address_interface_Class>;
  Fdisable_auto_group_change: Int64;
  Fextension_attributes: TsgcOpenAPI_customer_data_customer_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_customer_interface_Class;
public
//Customer id
  property Id: Int64 read Fid write Fid;
//Group id
  property Group_id: Int64 read Fgroup_id write Fgroup_id;
//Default billing address id
  property Default_billing: String read Fdefault_billing write Fdefault_billing;
//Default shipping address id
  property Default_shipping: String read Fdefault_shipping write Fdefault_shipping;
//Confirmation
  property Confirmation: String read Fconfirmation write Fconfirmation;
//Created at time
  property Created_at: String read Fcreated_at write Fcreated_at;
//Updated at time
  property Updated_at: String read Fupdated_at write Fupdated_at;
//Created in area
  property Created_in: String read Fcreated_in write Fcreated_in;
//In keeping with current security and privacy best practices, be sure you are aware of any potential legal and security risks associated with the storage of customers’ full date of birth (month, day, year) along with other personal identifiers (e.g., full name) before collecting or processing such data.
  property Dob: String read Fdob write Fdob;
//Email address
  property Email: String read Femail write Femail;
//First name
  property Firstname: String read Ffirstname write Ffirstname;
//Last name
  property Lastname: String read Flastname write Flastname;
//Middle name
  property Middlename: String read Fmiddlename write Fmiddlename;
//Prefix
  property Prefix: String read Fprefix write Fprefix;
//Suffix
  property Suffix: String read Fsuffix write Fsuffix;
//Gender
  property Gender: Int64 read Fgender write Fgender;
//Store id
  property Store_id: Int64 read Fstore_id write Fstore_id;
//Tax Vat
  property Taxvat: String read Ftaxvat write Ftaxvat;
//Website id
  property Website_id: Int64 read Fwebsite_id write Fwebsite_id;
//Customer addresses.
  property Addresses: TArray<TsgcOpenAPI_customer_data_address_interface_Class> read Faddresses write Faddresses;
//Disable auto group change flag.
  property Disable_auto_group_change: Int64 read Fdisable_auto_group_change write Fdisable_auto_group_change;
  property Extension_attributes: TsgcOpenAPI_customer_data_customer_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//Customer address interface.
TsgcOpenAPI_customer_data_address_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fcustomer_id: Int64;
  Fregion: TsgcOpenAPI_customer_data_region_interface_Class;
  Fregion_id: Int64;
  Fcountry_id: String;
  Fstreet: TArray<string>;
  Fcompany: String;
  Ftelephone: String;
  Ffax: String;
  Fpostcode: String;
  Fcity: String;
  Ffirstname: String;
  Flastname: String;
  Fmiddlename: String;
  Fprefix: String;
  Fsuffix: String;
  Fvat_id: String;
  Fdefault_shipping: Boolean;
  Fdefault_billing: Boolean;
  Fextension_attributes: TsgcOpenAPI_customer_data_address_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_address_interface_Class;
public
//ID
  property Id: Int64 read Fid write Fid;
//Customer ID
  property Customer_id: Int64 read Fcustomer_id write Fcustomer_id;
  property Region: TsgcOpenAPI_customer_data_region_interface_Class read Fregion write Fregion;
//Region ID
  property Region_id: Int64 read Fregion_id write Fregion_id;
//Country code in ISO_3166-2 format
  property Country_id: String read Fcountry_id write Fcountry_id;
//Street
  property Street: TArray<string> read Fstreet write Fstreet;
//Company
  property Company: String read Fcompany write Fcompany;
//Telephone number
  property Telephone: String read Ftelephone write Ftelephone;
//Fax number
  property Fax: String read Ffax write Ffax;
//Postcode
  property Postcode: String read Fpostcode write Fpostcode;
//City name
  property City: String read Fcity write Fcity;
//First name
  property Firstname: String read Ffirstname write Ffirstname;
//Last name
  property Lastname: String read Flastname write Flastname;
//Middle name
  property Middlename: String read Fmiddlename write Fmiddlename;
//Prefix
  property Prefix: String read Fprefix write Fprefix;
//Suffix
  property Suffix: String read Fsuffix write Fsuffix;
//Vat id
  property Vat_id: String read Fvat_id write Fvat_id;
//If this address is default shipping address.
  property Default_shipping: Boolean read Fdefault_shipping write Fdefault_shipping;
//If this address is default billing address
  property Default_billing: Boolean read Fdefault_billing write Fdefault_billing;
  property Extension_attributes: TsgcOpenAPI_customer_data_address_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//Customer address region interface.
TsgcOpenAPI_customer_data_region_interface_Class = class(TsgcOpenAPIClass)
private
  Fregion_code: String;
  Fregion: String;
  Fregion_id: Int64;
  Fextension_attributes: TsgcOpenAPI_customer_data_region_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_region_interface_Class;
public
//Region code
  property Region_code: String read Fregion_code write Fregion_code;
//Region
  property Region: String read Fregion write Fregion;
//Region id
  property Region_id: Int64 read Fregion_id write Fregion_id;
  property Extension_attributes: TsgcOpenAPI_customer_data_region_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Customer\Api\Data\RegionInterface
TsgcOpenAPI_customer_data_region_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_region_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Customer\Api\Data\AddressInterface
TsgcOpenAPI_customer_data_address_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_address_extension_interface_Class;
end;


//Description
//Interface for custom attribute value.
TsgcOpenAPI_framework_attribute_interface_Class = class(TsgcOpenAPIClass)
private
  Fattribute_code: String;
  Fvalue: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_attribute_interface_Class;
public
//Attribute code
  property Attribute_code: String read Fattribute_code write Fattribute_code;
//Attribute value
  property Value: String read Fvalue write Fvalue;
end;


//Description
//ExtensionInterface class for @see \Magento\Customer\Api\Data\CustomerInterface
TsgcOpenAPI_customer_data_customer_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fassistance_allowed: Int64;
  Fis_subscribed: Boolean;
public
  class function Read(const aValue: string): TsgcOpenAPI_customer_data_customer_extension_interface_Class;
public
  property Assistance_allowed: Int64 read Fassistance_allowed write Fassistance_allowed;
  property Is_subscribed: Boolean read Fis_subscribed write Fis_subscribed;
end;


//Description
//Interface SearchResultInterface
TsgcOpenAPI_framework_search_search_result_interface_Class = class(TsgcOpenAPIClass)
private
  Fitems: TArray<TsgcOpenAPI_framework_search_document_interface_Class>;
  Faggregations: TsgcOpenAPI_framework_search_aggregation_interface_Class;
  Fsearch_criteria: TsgcOpenAPI_framework_search_search_criteria_interface_Class;
  Ftotal_count: Int64;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_search_result_interface_Class;
public
  property Items: TArray<TsgcOpenAPI_framework_search_document_interface_Class> read Fitems write Fitems;
  property Aggregations: TsgcOpenAPI_framework_search_aggregation_interface_Class read Faggregations write Faggregations;
  property Search_criteria: TsgcOpenAPI_framework_search_search_criteria_interface_Class read Fsearch_criteria write Fsearch_criteria;
//Total count.
  property Total_count: Int64 read Ftotal_count write Ftotal_count;
end;


//Description
//Interface Search Document
TsgcOpenAPI_framework_search_document_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_document_interface_Class;
public
  property Id: Int64 read Fid write Fid;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//Interface Aggregation to get faceted data
TsgcOpenAPI_framework_search_aggregation_interface_Class = class(TsgcOpenAPIClass)
private
  Fbuckets: TArray<TsgcOpenAPI_framework_search_bucket_interface_Class>;
  Fbucket_names: TArray<string>;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_aggregation_interface_Class;
public
//All Document fields
  property Buckets: TArray<TsgcOpenAPI_framework_search_bucket_interface_Class> read Fbuckets write Fbuckets;
//Document field names
  property Bucket_names: TArray<string> read Fbucket_names write Fbucket_names;
end;


//Description
//Interface for facet Bucket
TsgcOpenAPI_framework_search_bucket_interface_Class = class(TsgcOpenAPIClass)
private
  Fname: String;
  Fvalues: TArray<TsgcOpenAPI_framework_search_aggregation_value_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_bucket_interface_Class;
public
//Field name
  property Name: String read Fname write Fname;
//Field values
  property Values: TArray<TsgcOpenAPI_framework_search_aggregation_value_interface_Class> read Fvalues write Fvalues;
end;


//Description
//Interface Aggregation Value
TsgcOpenAPI_framework_search_aggregation_value_interface_Class = class(TsgcOpenAPIClass)
private
  Fvalue: String;
  Fmetrics: TArray<string>;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_aggregation_value_interface_Class;
public
//Aggregation
  property Value: String read Fvalue write Fvalue;
//Metrics
  property Metrics: TArray<string> read Fmetrics write Fmetrics;
end;


//Description
//Interface SearchCriteriaInterface
TsgcOpenAPI_framework_search_search_criteria_interface_Class = class(TsgcOpenAPIClass)
private
  Frequest_name: String;
  Ffilter_groups: TArray<TsgcOpenAPI_framework_search_filter_group_Class>;
  Fsort_orders: TArray<TsgcOpenAPI_framework_sort_order_Class>;
  Fpage_size: Int64;
  Fcurrent_page: Int64;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_search_criteria_interface_Class;
public
  property Request_name: String read Frequest_name write Frequest_name;
//A list of filter groups.
  property Filter_groups: TArray<TsgcOpenAPI_framework_search_filter_group_Class> read Ffilter_groups write Ffilter_groups;
//Sort order.
  property Sort_orders: TArray<TsgcOpenAPI_framework_sort_order_Class> read Fsort_orders write Fsort_orders;
//Page size.
  property Page_size: Int64 read Fpage_size write Fpage_size;
//Current page.
  property Current_page: Int64 read Fcurrent_page write Fcurrent_page;
end;


//Description
//Groups two or more filters together using a logical OR
TsgcOpenAPI_framework_search_filter_group_Class = class(TsgcOpenAPIClass)
private
  Ffilters: TArray<TsgcOpenAPI_framework_filter_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_search_filter_group_Class;
public
//A list of filters in this group
  property Filters: TArray<TsgcOpenAPI_framework_filter_Class> read Ffilters write Ffilters;
end;


//Description
//Filter which can be used by any methods from service layer.
TsgcOpenAPI_framework_filter_Class = class(TsgcOpenAPIClass)
private
  Ffield: String;
  Fvalue: String;
  Fcondition_type: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_filter_Class;
public
//Field
  property Field: String read Ffield write Ffield;
//Value
  property Value: String read Fvalue write Fvalue;
//Condition type
  property Condition_type: String read Fcondition_type write Fcondition_type;
end;


//Description
//Data object for sort order.
TsgcOpenAPI_framework_sort_order_Class = class(TsgcOpenAPIClass)
private
  Ffield: String;
  Fdirection: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_sort_order_Class;
public
//Sorting field.
  property Field: String read Ffield write Ffield;
//Sorting direction.
  property Direction: String read Fdirection write Fdirection;
end;


//Description
//Dto that holds render information about products
TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class = class(TsgcOpenAPIClass)
private
  Fitems: TArray<TsgcOpenAPI_catalog_data_product_render_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class;
public
//List of products rendered information
  property Items: TArray<TsgcOpenAPI_catalog_data_product_render_interface_Class> read Fitems write Fitems;
end;


//Description
//Represents Data Object which holds enough information to render product This information is put into part as Add To Cart or Add to Compare Data or Price Data
TsgcOpenAPI_catalog_data_product_render_interface_Class = class(TsgcOpenAPIClass)
private
  Fadd_to_cart_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class;
  Fadd_to_compare_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class;
  Fprice_info: TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class;
  Fimages: TArray<TsgcOpenAPI_catalog_data_product_render_image_interface_Class>;
  Furl: String;
  Fid: Int64;
  Fname: String;
  Ftype: String;
  Fis_salable: String;
  Fstore_id: Int64;
  Fcurrency_code: String;
  Fextension_attributes: TsgcOpenAPI_catalog_data_product_render_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_interface_Class;
public
  property Add_to_cart_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class read Fadd_to_cart_button write Fadd_to_cart_button;
  property Add_to_compare_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class read Fadd_to_compare_button write Fadd_to_compare_button;
  property Price_info: TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class read Fprice_info write Fprice_info;
//Enough information, that needed to render image on front
  property Images: TArray<TsgcOpenAPI_catalog_data_product_render_image_interface_Class> read Fimages write Fimages;
//Product url
  property Url: String read Furl write Furl;
//Product identifier
  property Id: Int64 read Fid write Fid;
//Product name
  property Name: String read Fname write Fname;
//Product type. Such as bundle, grouped, simple, etc...
  property _type: String read Ftype write Ftype;
//Information about product saleability (In Stock)
  property Is_salable: String read Fis_salable write Fis_salable;
//Information about current store id or requested store id
  property Store_id: Int64 read Fstore_id write Fstore_id;
//Current or desired currency code to product
  property Currency_code: String read Fcurrency_code write Fcurrency_code;
  property Extension_attributes: TsgcOpenAPI_catalog_data_product_render_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Button interface. This interface represents all manner of product buttons: add to cart, add to compare, etc... The buttons describes by this interface should have interaction with backend
TsgcOpenAPI_catalog_data_product_render_button_interface_Class = class(TsgcOpenAPIClass)
private
  Fpost_data: String;
  Furl: String;
  Frequired_options: Boolean;
  Fextension_attributes: TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_button_interface_Class;
public
//Post data
  property Post_data: String read Fpost_data write Fpost_data;
//Url, needed to add product to cart
  property Url: String read Furl write Furl;
//Flag whether a product has options or not
  property Required_options: Boolean read Frequired_options write Frequired_options;
  property Extension_attributes: TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\ProductRender\ButtonInterface
TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class;
end;


//Description
//Price interface.
TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class = class(TsgcOpenAPIClass)
private
  Ffinal_price: Extended;
  Fmax_price: Extended;
  Fmax_regular_price: Extended;
  Fminimal_regular_price: Extended;
  Fspecial_price: Extended;
  Fminimal_price: Extended;
  Fregular_price: Extended;
  Fformatted_prices: TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class;
  Fextension_attributes: TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class;
public
//Final price
  property Final_price: Extended read Ffinal_price write Ffinal_price;
//Max price of a product
  property Max_price: Extended read Fmax_price write Fmax_price;
//Max regular price
  property Max_regular_price: Extended read Fmax_regular_price write Fmax_regular_price;
//Minimal regular price
  property Minimal_regular_price: Extended read Fminimal_regular_price write Fminimal_regular_price;
//Special price
  property Special_price: Extended read Fspecial_price write Fspecial_price;
//Minimal price
  property Minimal_price: Extended read Fminimal_price write Fminimal_price;
//Regular price
  property Regular_price: Extended read Fregular_price write Fregular_price;
  property Formatted_prices: TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class read Fformatted_prices write Fformatted_prices;
  property Extension_attributes: TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Formatted Price interface. Aggregate formatted html with price representations. E.g.: <span class="price">$9.00</span> Consider currency, rounding and html
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class = class(TsgcOpenAPIClass)
private
  Ffinal_price: String;
  Fmax_price: String;
  Fminimal_price: String;
  Fmax_regular_price: String;
  Fminimal_regular_price: String;
  Fspecial_price: String;
  Fregular_price: String;
  Fextension_attributes: TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class;
public
//Html with final price
  property Final_price: String read Ffinal_price write Ffinal_price;
//Max price of a product
  property Max_price: String read Fmax_price write Fmax_price;
//The minimal price of the product or variation
  property Minimal_price: String read Fminimal_price write Fminimal_price;
//Max regular price
  property Max_regular_price: String read Fmax_regular_price write Fmax_regular_price;
//Minimal regular price
  property Minimal_regular_price: String read Fminimal_regular_price write Fminimal_regular_price;
//Special price
  property Special_price: String read Fspecial_price write Fspecial_price;
//Price - is price of product without discounts and special price with taxes and fixed product tax
  property Regular_price: String read Fregular_price write Fregular_price;
  property Extension_attributes: TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\ProductRender\FormattedPriceInfoInterface
TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\ProductRender\PriceInfoInterface
TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fmsrp: TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class;
  Ftax_adjustments: TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class;
  Fweee_attributes: TArray<TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class>;
  Fweee_adjustment: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class;
public
  property Msrp: TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class read Fmsrp write Fmsrp;
  property Tax_adjustments: TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class read Ftax_adjustments write Ftax_adjustments;
  property Weee_attributes: TArray<TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class> read Fweee_attributes write Fweee_attributes;
  property Weee_adjustment: String read Fweee_adjustment write Fweee_adjustment;
end;


//Description
//Price interface.
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class = class(TsgcOpenAPIClass)
private
  Fmsrp_price: String;
  Fis_applicable: String;
  Fis_shown_price_on_gesture: String;
  Fmsrp_message: String;
  Fexplanation_message: String;
  Fextension_attributes: TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class;
public
  property Msrp_price: String read Fmsrp_price write Fmsrp_price;
  property Is_applicable: String read Fis_applicable write Fis_applicable;
  property Is_shown_price_on_gesture: String read Fis_shown_price_on_gesture write Fis_shown_price_on_gesture;
  property Msrp_message: String read Fmsrp_message write Fmsrp_message;
  property Explanation_message: String read Fexplanation_message write Fexplanation_message;
  property Extension_attributes: TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Msrp\Api\Data\ProductRender\MsrpPriceInfoInterface
TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class;
end;


//Description
//List of all weee attributes, their amounts, etc.., that product has
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class = class(TsgcOpenAPIClass)
private
  Famount: String;
  Ftax_amount: String;
  Ftax_amount_incl_tax: String;
  Famount_excl_tax: String;
  Fattribute_code: String;
  Fextension_attributes: TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class;
public
//Weee attribute amount
  property Amount: String read Famount write Famount;
//Tax which is calculated to fixed product tax attribute
  property Tax_amount: String read Ftax_amount write Ftax_amount;
//Tax amount of weee attribute
  property Tax_amount_incl_tax: String read Ftax_amount_incl_tax write Ftax_amount_incl_tax;
//Product amount exclude tax
  property Amount_excl_tax: String read Famount_excl_tax write Famount_excl_tax;
//Weee attribute code
  property Attribute_code: String read Fattribute_code write Fattribute_code;
  property Extension_attributes: TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Weee\Api\Data\ProductRender\WeeeAdjustmentAttributeInterface
TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class;
end;


//Description
//Product Render image interface. Represents physical characteristics of image, that can be used in product listing or product view
TsgcOpenAPI_catalog_data_product_render_image_interface_Class = class(TsgcOpenAPIClass)
private
  Furl: String;
  Fcode: String;
  Fheight: Extended;
  Fwidth: Extended;
  Flabel: String;
  Fresized_width: Extended;
  Fresized_height: Extended;
  Fextension_attributes: TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_image_interface_Class;
public
//Image url
  property Url: String read Furl write Furl;
//Image code
  property Code: String read Fcode write Fcode;
//Image height
  property Height: Extended read Fheight write Fheight;
//Image width in px
  property Width: Extended read Fwidth write Fwidth;
//Image label
  property _label: String read Flabel write Flabel;
//Resize width
  property Resized_width: Extended read Fresized_width write Fresized_width;
//Resize height
  property Resized_height: Extended read Fresized_height write Fresized_height;
  property Extension_attributes: TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\ProductRender\ImageInterface
TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\ProductRenderInterface
TsgcOpenAPI_catalog_data_product_render_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Freview_html: String;
  Fwishlist_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_extension_interface_Class;
public
  property Review_html: String read Freview_html write Freview_html;
  property Wishlist_button: TsgcOpenAPI_catalog_data_product_render_button_interface_Class read Fwishlist_button write Fwishlist_button;
end;


//Description
//Interface CartInterface
TsgcOpenAPI_quote_data_cart_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fcreated_at: String;
  Fupdated_at: String;
  Fconverted_at: String;
  Fis_active: Boolean;
  Fis_virtual: Boolean;
  Fitems: TArray<TsgcOpenAPI_quote_data_cart_item_interface_Class>;
  Fitems_count: Int64;
  Fitems_qty: Extended;
  Fcustomer: TsgcOpenAPI_customer_data_customer_interface_Class;
  Fbilling_address: TsgcOpenAPI_quote_data_address_interface_Class;
  Freserved_order_id: String;
  Forig_order_id: Int64;
  Fcurrency: TsgcOpenAPI_quote_data_currency_interface_Class;
  Fcustomer_is_guest: Boolean;
  Fcustomer_note: String;
  Fcustomer_note_notify: Boolean;
  Fcustomer_tax_class_id: Int64;
  Fstore_id: Int64;
  Fextension_attributes: TsgcOpenAPI_quote_data_cart_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_cart_interface_Class;
public
//Cart/quote ID.
  property Id: Int64 read Fid write Fid;
//Cart creation date and time. Otherwise, null.
  property Created_at: String read Fcreated_at write Fcreated_at;
//Cart last update date and time. Otherwise, null.
  property Updated_at: String read Fupdated_at write Fupdated_at;
//Cart conversion date and time. Otherwise, null.
  property Converted_at: String read Fconverted_at write Fconverted_at;
//Active status flag value. Otherwise, null.
  property Is_active: Boolean read Fis_active write Fis_active;
//Virtual flag value. Otherwise, null.
  property Is_virtual: Boolean read Fis_virtual write Fis_virtual;
//Array of items. Otherwise, null.
  property Items: TArray<TsgcOpenAPI_quote_data_cart_item_interface_Class> read Fitems write Fitems;
//Number of different items or products in the cart. Otherwise, null.
  property Items_count: Int64 read Fitems_count write Fitems_count;
//Total quantity of all cart items. Otherwise, null.
  property Items_qty: Extended read Fitems_qty write Fitems_qty;
  property Customer: TsgcOpenAPI_customer_data_customer_interface_Class read Fcustomer write Fcustomer;
  property Billing_address: TsgcOpenAPI_quote_data_address_interface_Class read Fbilling_address write Fbilling_address;
//Reserved order ID. Otherwise, null.
  property Reserved_order_id: String read Freserved_order_id write Freserved_order_id;
//Original order ID. Otherwise, null.
  property Orig_order_id: Int64 read Forig_order_id write Forig_order_id;
  property Currency: TsgcOpenAPI_quote_data_currency_interface_Class read Fcurrency write Fcurrency;
//For guest customers, false for logged in customers
  property Customer_is_guest: Boolean read Fcustomer_is_guest write Fcustomer_is_guest;
//Notice text
  property Customer_note: String read Fcustomer_note write Fcustomer_note;
//Customer notification flag
  property Customer_note_notify: Boolean read Fcustomer_note_notify write Fcustomer_note_notify;
//Customer tax class ID.
  property Customer_tax_class_id: Int64 read Fcustomer_tax_class_id write Fcustomer_tax_class_id;
//Store identifier
  property Store_id: Int64 read Fstore_id write Fstore_id;
  property Extension_attributes: TsgcOpenAPI_quote_data_cart_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Interface CartItemInterface
TsgcOpenAPI_quote_data_cart_item_interface_Class = class(TsgcOpenAPIClass)
private
  Fitem_id: Int64;
  Fsku: String;
  Fqty: Extended;
  Fname: String;
  Fprice: Extended;
  Fproduct_type: String;
  Fquote_id: String;
  Fproduct_option: TsgcOpenAPI_quote_data_product_option_interface_Class;
  Fextension_attributes: TsgcOpenAPI_quote_data_cart_item_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_cart_item_interface_Class;
public
//Item ID. Otherwise, null.
  property Item_id: Int64 read Fitem_id write Fitem_id;
//Product SKU. Otherwise, null.
  property Sku: String read Fsku write Fsku;
//Product quantity.
  property Qty: Extended read Fqty write Fqty;
//Product name. Otherwise, null.
  property Name: String read Fname write Fname;
//Product price. Otherwise, null.
  property Price: Extended read Fprice write Fprice;
//Product type. Otherwise, null.
  property Product_type: String read Fproduct_type write Fproduct_type;
//Quote id.
  property Quote_id: String read Fquote_id write Fquote_id;
  property Product_option: TsgcOpenAPI_quote_data_product_option_interface_Class read Fproduct_option write Fproduct_option;
  property Extension_attributes: TsgcOpenAPI_quote_data_cart_item_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Product option interface
TsgcOpenAPI_quote_data_product_option_interface_Class = class(TsgcOpenAPIClass)
private
  Fextension_attributes: TsgcOpenAPI_quote_data_product_option_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_product_option_interface_Class;
public
  property Extension_attributes: TsgcOpenAPI_quote_data_product_option_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\ProductOptionInterface
TsgcOpenAPI_quote_data_product_option_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fcustom_options: TArray<TsgcOpenAPI_catalog_data_custom_option_interface_Class>;
  Fdownloadable_option: TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class;
  Fbundle_options: TArray<TsgcOpenAPI_bundle_data_bundle_option_interface_Class>;
  Fgrouped_options: TArray<TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class>;
  Fconfigurable_item_options: TArray<TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_product_option_extension_interface_Class;
public
  property Custom_options: TArray<TsgcOpenAPI_catalog_data_custom_option_interface_Class> read Fcustom_options write Fcustom_options;
  property Downloadable_option: TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class read Fdownloadable_option write Fdownloadable_option;
  property Bundle_options: TArray<TsgcOpenAPI_bundle_data_bundle_option_interface_Class> read Fbundle_options write Fbundle_options;
  property Grouped_options: TArray<TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class> read Fgrouped_options write Fgrouped_options;
  property Configurable_item_options: TArray<TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class> read Fconfigurable_item_options write Fconfigurable_item_options;
end;


//Description
//Interface CustomOptionInterface
TsgcOpenAPI_catalog_data_custom_option_interface_Class = class(TsgcOpenAPIClass)
private
  Foption_id: String;
  Foption_value: String;
  Fextension_attributes: TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_custom_option_interface_Class;
public
//Option id
  property Option_id: String read Foption_id write Foption_id;
//Option value
  property Option_value: String read Foption_value write Foption_value;
  property Extension_attributes: TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Catalog\Api\Data\CustomOptionInterface
TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Ffile_info: TsgcOpenAPI_framework_data_image_content_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class;
public
  property File_info: TsgcOpenAPI_framework_data_image_content_interface_Class read Ffile_info write Ffile_info;
end;


//Description
//Image Content data interface
TsgcOpenAPI_framework_data_image_content_interface_Class = class(TsgcOpenAPIClass)
private
  Fbase64_encoded_data: String;
  Ftype: String;
  Fname: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_framework_data_image_content_interface_Class;
public
//Media data (base64 encoded content)
  property Base64_encoded_data: String read Fbase64_encoded_data write Fbase64_encoded_data;
//MIME type
  property _type: String read Ftype write Ftype;
//Image name
  property Name: String read Fname write Fname;
end;


//Description
//Downloadable Option
TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class = class(TsgcOpenAPIClass)
private
  Fdownloadable_links: TArray<integer>;
public
  class function Read(const aValue: string): TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class;
public
//The list of downloadable links
  property Downloadable_links: TArray<integer> read Fdownloadable_links write Fdownloadable_links;
end;


//Description
//Interface BundleOptionInterface
TsgcOpenAPI_bundle_data_bundle_option_interface_Class = class(TsgcOpenAPIClass)
private
  Foption_id: Int64;
  Foption_qty: Int64;
  Foption_selections: TArray<integer>;
  Fextension_attributes: TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_bundle_data_bundle_option_interface_Class;
public
//Bundle option id.
  property Option_id: Int64 read Foption_id write Foption_id;
//Bundle option quantity.
  property Option_qty: Int64 read Foption_qty write Foption_qty;
//Bundle option selection ids.
  property Option_selections: TArray<integer> read Foption_selections write Foption_selections;
  property Extension_attributes: TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Bundle\Api\Data\BundleOptionInterface
TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class;
end;


//Description
//Represents `product item id with qty` of a grouped product.
TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fqty: Int64;
  Fextension_attributes: TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class;
public
//Associated product id
  property Id: Int64 read Fid write Fid;
//Associated product qty
  property Qty: Int64 read Fqty write Fqty;
  property Extension_attributes: TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\GroupedProduct\Api\Data\GroupedOptionsInterface
TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class;
end;


//Description
//Interface ConfigurableItemOptionValueInterface
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class = class(TsgcOpenAPIClass)
private
  Foption_id: String;
  Foption_value: Int64;
  Fextension_attributes: TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class;
public
//Option SKU
  property Option_id: String read Foption_id write Foption_id;
//Item id
  property Option_value: Int64 read Foption_value write Foption_value;
  property Extension_attributes: TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\ConfigurableProduct\Api\Data\ConfigurableItemOptionValueInterface
TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\CartItemInterface
TsgcOpenAPI_quote_data_cart_item_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fdiscounts: TArray<TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_cart_item_extension_interface_Class;
public
  property Discounts: TArray<TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class> read Fdiscounts write Fdiscounts;
end;


//Description
//Rule discount Interface
TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class = class(TsgcOpenAPIClass)
private
  Fdiscount_data: TsgcOpenAPI_sales_rule_data_discount_data_interface_Class;
  Frule_label: String;
  Frule_id: Int64;
public
  class function Read(const aValue: string): TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class;
public
  property Discount_data: TsgcOpenAPI_sales_rule_data_discount_data_interface_Class read Fdiscount_data write Fdiscount_data;
//Rule Label
  property Rule_label: String read Frule_label write Frule_label;
//Rule ID
  property Rule_id: Int64 read Frule_id write Frule_id;
end;


//Description
//Discount Data Interface
TsgcOpenAPI_sales_rule_data_discount_data_interface_Class = class(TsgcOpenAPIClass)
private
  Famount: Extended;
  Fbase_amount: Extended;
  Foriginal_amount: Extended;
  Fbase_original_amount: Extended;
public
  class function Read(const aValue: string): TsgcOpenAPI_sales_rule_data_discount_data_interface_Class;
public
//Amount
  property Amount: Extended read Famount write Famount;
//Base Amount
  property Base_amount: Extended read Fbase_amount write Fbase_amount;
//Original Amount
  property Original_amount: Extended read Foriginal_amount write Foriginal_amount;
//Base Original Amount
  property Base_original_amount: Extended read Fbase_original_amount write Fbase_original_amount;
end;


//Description
//Interface AddressInterface
TsgcOpenAPI_quote_data_address_interface_Class = class(TsgcOpenAPIClass)
private
  Fid: Int64;
  Fregion: String;
  Fregion_id: Int64;
  Fregion_code: String;
  Fcountry_id: String;
  Fstreet: TArray<string>;
  Fcompany: String;
  Ftelephone: String;
  Ffax: String;
  Fpostcode: String;
  Fcity: String;
  Ffirstname: String;
  Flastname: String;
  Fmiddlename: String;
  Fprefix: String;
  Fsuffix: String;
  Fvat_id: String;
  Fcustomer_id: Int64;
  Femail: String;
  Fsame_as_billing: Int64;
  Fcustomer_address_id: Int64;
  Fsave_in_address_book: Int64;
  Fextension_attributes: TsgcOpenAPI_quote_data_address_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_address_interface_Class;
public
//Id
  property Id: Int64 read Fid write Fid;
//Region name
  property Region: String read Fregion write Fregion;
//Region id
  property Region_id: Int64 read Fregion_id write Fregion_id;
//Region code
  property Region_code: String read Fregion_code write Fregion_code;
//Country id
  property Country_id: String read Fcountry_id write Fcountry_id;
//Street
  property Street: TArray<string> read Fstreet write Fstreet;
//Company
  property Company: String read Fcompany write Fcompany;
//Telephone number
  property Telephone: String read Ftelephone write Ftelephone;
//Fax number
  property Fax: String read Ffax write Ffax;
//Postcode
  property Postcode: String read Fpostcode write Fpostcode;
//City name
  property City: String read Fcity write Fcity;
//First name
  property Firstname: String read Ffirstname write Ffirstname;
//Last name
  property Lastname: String read Flastname write Flastname;
//Middle name
  property Middlename: String read Fmiddlename write Fmiddlename;
//Prefix
  property Prefix: String read Fprefix write Fprefix;
//Suffix
  property Suffix: String read Fsuffix write Fsuffix;
//Vat id
  property Vat_id: String read Fvat_id write Fvat_id;
//Customer id
  property Customer_id: Int64 read Fcustomer_id write Fcustomer_id;
//Billing/shipping email
  property Email: String read Femail write Femail;
//Same as billing flag
  property Same_as_billing: Int64 read Fsame_as_billing write Fsame_as_billing;
//Customer address id
  property Customer_address_id: Int64 read Fcustomer_address_id write Fcustomer_address_id;
//Save in address book flag
  property Save_in_address_book: Int64 read Fsave_in_address_book write Fsave_in_address_book;
  property Extension_attributes: TsgcOpenAPI_quote_data_address_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\AddressInterface
TsgcOpenAPI_quote_data_address_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fpickup_location_code: String;
  Fdiscounts: TArray<TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_address_extension_interface_Class;
public
  property Pickup_location_code: String read Fpickup_location_code write Fpickup_location_code;
  property Discounts: TArray<TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class> read Fdiscounts write Fdiscounts;
end;


//Description
//Interface CurrencyInterface
TsgcOpenAPI_quote_data_currency_interface_Class = class(TsgcOpenAPIClass)
private
  Fglobal_currency_code: String;
  Fbase_currency_code: String;
  Fstore_currency_code: String;
  Fquote_currency_code: String;
  Fstore_to_base_rate: Extended;
  Fstore_to_quote_rate: Extended;
  Fbase_to_global_rate: Extended;
  Fbase_to_quote_rate: Extended;
  Fextension_attributes: TsgcOpenAPI_quote_data_currency_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_currency_interface_Class;
public
//Global currency code
  property Global_currency_code: String read Fglobal_currency_code write Fglobal_currency_code;
//Base currency code
  property Base_currency_code: String read Fbase_currency_code write Fbase_currency_code;
//Store currency code
  property Store_currency_code: String read Fstore_currency_code write Fstore_currency_code;
//Quote currency code
  property Quote_currency_code: String read Fquote_currency_code write Fquote_currency_code;
//Store currency to base currency rate
  property Store_to_base_rate: Extended read Fstore_to_base_rate write Fstore_to_base_rate;
//Store currency to quote currency rate
  property Store_to_quote_rate: Extended read Fstore_to_quote_rate write Fstore_to_quote_rate;
//Base currency to global currency rate
  property Base_to_global_rate: Extended read Fbase_to_global_rate write Fbase_to_global_rate;
//Base currency to quote currency rate
  property Base_to_quote_rate: Extended read Fbase_to_quote_rate write Fbase_to_quote_rate;
  property Extension_attributes: TsgcOpenAPI_quote_data_currency_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\CurrencyInterface
TsgcOpenAPI_quote_data_currency_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_currency_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\CartInterface
TsgcOpenAPI_quote_data_cart_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fshipping_assignments: TArray<TsgcOpenAPI_quote_data_shipping_assignment_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_cart_extension_interface_Class;
public
  property Shipping_assignments: TArray<TsgcOpenAPI_quote_data_shipping_assignment_interface_Class> read Fshipping_assignments write Fshipping_assignments;
end;


//Description
//Interface ShippingAssignmentInterface
TsgcOpenAPI_quote_data_shipping_assignment_interface_Class = class(TsgcOpenAPIClass)
private
  Fshipping: TsgcOpenAPI_quote_data_shipping_interface_Class;
  Fitems: TArray<TsgcOpenAPI_quote_data_cart_item_interface_Class>;
  Fextension_attributes: TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_assignment_interface_Class;
public
  property Shipping: TsgcOpenAPI_quote_data_shipping_interface_Class read Fshipping write Fshipping;
  property Items: TArray<TsgcOpenAPI_quote_data_cart_item_interface_Class> read Fitems write Fitems;
  property Extension_attributes: TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Interface ShippingInterface
TsgcOpenAPI_quote_data_shipping_interface_Class = class(TsgcOpenAPIClass)
private
  Faddress: TsgcOpenAPI_quote_data_address_interface_Class;
  Fmethod: String;
  Fextension_attributes: TsgcOpenAPI_quote_data_shipping_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_interface_Class;
public
  property Address: TsgcOpenAPI_quote_data_address_interface_Class read Faddress write Faddress;
//Shipping method
  property Method: String read Fmethod write Fmethod;
  property Extension_attributes: TsgcOpenAPI_quote_data_shipping_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\ShippingInterface
TsgcOpenAPI_quote_data_shipping_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_extension_interface_Class;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\ShippingAssignmentInterface
TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class;
end;


//Description
//Interface PaymentInterface
TsgcOpenAPI_quote_data_payment_interface_Class = class(TsgcOpenAPIClass)
private
  Fpo_number: String;
  Fmethod: String;
  Fadditional_data: TArray<string>;
  Fextension_attributes: TsgcOpenAPI_quote_data_payment_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_payment_interface_Class;
public
//Purchase order number
  property Po_number: String read Fpo_number write Fpo_number;
//Payment method code
  property Method: String read Fmethod write Fmethod;
//Payment additional details
  property Additional_data: TArray<string> read Fadditional_data write Fadditional_data;
  property Extension_attributes: TsgcOpenAPI_quote_data_payment_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\PaymentInterface
TsgcOpenAPI_quote_data_payment_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fagreement_ids: TArray<string>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_payment_extension_interface_Class;
public
  property Agreement_ids: TArray<string> read Fagreement_ids write Fagreement_ids;
end;


//Description
//Interface ShippingMethodInterface
TsgcOpenAPI_quote_data_shipping_method_interface_Class = class(TsgcOpenAPIClass)
private
  Fcarrier_code: String;
  Fmethod_code: String;
  Fcarrier_title: String;
  Fmethod_title: String;
  Famount: Extended;
  Fbase_amount: Extended;
  Favailable: Boolean;
  Fextension_attributes: TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class;
  Ferror_message: String;
  Fprice_excl_tax: Extended;
  Fprice_incl_tax: Extended;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_method_interface_Class;
public
//Shipping carrier code.
  property Carrier_code: String read Fcarrier_code write Fcarrier_code;
//Shipping method code.
  property Method_code: String read Fmethod_code write Fmethod_code;
//Shipping carrier title. Otherwise, null.
  property Carrier_title: String read Fcarrier_title write Fcarrier_title;
//Shipping method title. Otherwise, null.
  property Method_title: String read Fmethod_title write Fmethod_title;
//Shipping amount in store currency.
  property Amount: Extended read Famount write Famount;
//Shipping amount in base currency.
  property Base_amount: Extended read Fbase_amount write Fbase_amount;
//The value of the availability flag for the current shipping method.
  property Available: Boolean read Favailable write Favailable;
  property Extension_attributes: TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Shipping Error message.
  property Error_message: String read Ferror_message write Ferror_message;
//Shipping price excl tax.
  property Price_excl_tax: Extended read Fprice_excl_tax write Fprice_excl_tax;
//Shipping price incl tax.
  property Price_incl_tax: Extended read Fprice_incl_tax write Fprice_incl_tax;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\ShippingMethodInterface
TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class;
end;


//Description
//Interface PaymentMethodInterface
TsgcOpenAPI_quote_data_payment_method_interface_Class = class(TsgcOpenAPIClass)
private
  Fcode: String;
  Ftitle: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_payment_method_interface_Class;
public
//Payment method code
  property Code: String read Fcode write Fcode;
//Payment method title
  property Title: String read Ftitle write Ftitle;
end;


//Description
//Additional data for totals collection.
TsgcOpenAPI_quote_data_totals_additional_data_interface_Class = class(TsgcOpenAPIClass)
private
  Fextension_attributes: TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_additional_data_interface_Class;
public
  property Extension_attributes: TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\TotalsAdditionalDataInterface
TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fgift_messages: TArray<TsgcOpenAPI_gift_message_data_message_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class;
public
  property Gift_messages: TArray<TsgcOpenAPI_gift_message_data_message_interface_Class> read Fgift_messages write Fgift_messages;
end;


//Description
//Interface MessageInterface
TsgcOpenAPI_gift_message_data_message_interface_Class = class(TsgcOpenAPIClass)
private
  Fgift_message_id: Int64;
  Fcustomer_id: Int64;
  Fsender: String;
  Frecipient: String;
  Fmessage: String;
  Fextension_attributes: TsgcOpenAPI_gift_message_data_message_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_gift_message_data_message_interface_Class;
public
//Gift message ID. Otherwise, null.
  property Gift_message_id: Int64 read Fgift_message_id write Fgift_message_id;
//Customer ID. Otherwise, null.
  property Customer_id: Int64 read Fcustomer_id write Fcustomer_id;
//Sender name.
  property Sender: String read Fsender write Fsender;
//Recipient name.
  property Recipient: String read Frecipient write Frecipient;
//Message text.
  property _message: String read Fmessage write Fmessage;
  property Extension_attributes: TsgcOpenAPI_gift_message_data_message_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\GiftMessage\Api\Data\MessageInterface
TsgcOpenAPI_gift_message_data_message_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fentity_id: String;
  Fentity_type: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_gift_message_data_message_extension_interface_Class;
public
  property Entity_id: String read Fentity_id write Fentity_id;
  property Entity_type: String read Fentity_type write Fentity_type;
end;


//Description
//Interface TotalsInterface
TsgcOpenAPI_quote_data_totals_interface_Class = class(TsgcOpenAPIClass)
private
  Fgrand_total: Extended;
  Fbase_grand_total: Extended;
  Fsubtotal: Extended;
  Fbase_subtotal: Extended;
  Fdiscount_amount: Extended;
  Fbase_discount_amount: Extended;
  Fsubtotal_with_discount: Extended;
  Fbase_subtotal_with_discount: Extended;
  Fshipping_amount: Extended;
  Fbase_shipping_amount: Extended;
  Fshipping_discount_amount: Extended;
  Fbase_shipping_discount_amount: Extended;
  Ftax_amount: Extended;
  Fbase_tax_amount: Extended;
  Fweee_tax_applied_amount: Extended;
  Fshipping_tax_amount: Extended;
  Fbase_shipping_tax_amount: Extended;
  Fsubtotal_incl_tax: Extended;
  Fbase_subtotal_incl_tax: Extended;
  Fshipping_incl_tax: Extended;
  Fbase_shipping_incl_tax: Extended;
  Fbase_currency_code: String;
  Fquote_currency_code: String;
  Fcoupon_code: String;
  Fitems_qty: Int64;
  Fitems: TArray<TsgcOpenAPI_quote_data_totals_item_interface_Class>;
  Ftotal_segments: TArray<TsgcOpenAPI_quote_data_total_segment_interface_Class>;
  Fextension_attributes: TsgcOpenAPI_quote_data_totals_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_interface_Class;
public
//Grand total in quote currency
  property Grand_total: Extended read Fgrand_total write Fgrand_total;
//Grand total in base currency
  property Base_grand_total: Extended read Fbase_grand_total write Fbase_grand_total;
//Subtotal in quote currency
  property Subtotal: Extended read Fsubtotal write Fsubtotal;
//Subtotal in base currency
  property Base_subtotal: Extended read Fbase_subtotal write Fbase_subtotal;
//Discount amount in quote currency
  property Discount_amount: Extended read Fdiscount_amount write Fdiscount_amount;
//Discount amount in base currency
  property Base_discount_amount: Extended read Fbase_discount_amount write Fbase_discount_amount;
//Subtotal in quote currency with applied discount
  property Subtotal_with_discount: Extended read Fsubtotal_with_discount write Fsubtotal_with_discount;
//Subtotal in base currency with applied discount
  property Base_subtotal_with_discount: Extended read Fbase_subtotal_with_discount write Fbase_subtotal_with_discount;
//Shipping amount in quote currency
  property Shipping_amount: Extended read Fshipping_amount write Fshipping_amount;
//Shipping amount in base currency
  property Base_shipping_amount: Extended read Fbase_shipping_amount write Fbase_shipping_amount;
//Shipping discount amount in quote currency
  property Shipping_discount_amount: Extended read Fshipping_discount_amount write Fshipping_discount_amount;
//Shipping discount amount in base currency
  property Base_shipping_discount_amount: Extended read Fbase_shipping_discount_amount write Fbase_shipping_discount_amount;
//Tax amount in quote currency
  property Tax_amount: Extended read Ftax_amount write Ftax_amount;
//Tax amount in base currency
  property Base_tax_amount: Extended read Fbase_tax_amount write Fbase_tax_amount;
//Item weee tax applied amount in quote currency.
  property Weee_tax_applied_amount: Extended read Fweee_tax_applied_amount write Fweee_tax_applied_amount;
//Shipping tax amount in quote currency
  property Shipping_tax_amount: Extended read Fshipping_tax_amount write Fshipping_tax_amount;
//Shipping tax amount in base currency
  property Base_shipping_tax_amount: Extended read Fbase_shipping_tax_amount write Fbase_shipping_tax_amount;
//Subtotal including tax in quote currency
  property Subtotal_incl_tax: Extended read Fsubtotal_incl_tax write Fsubtotal_incl_tax;
//Subtotal including tax in base currency
  property Base_subtotal_incl_tax: Extended read Fbase_subtotal_incl_tax write Fbase_subtotal_incl_tax;
//Shipping including tax in quote currency
  property Shipping_incl_tax: Extended read Fshipping_incl_tax write Fshipping_incl_tax;
//Shipping including tax in base currency
  property Base_shipping_incl_tax: Extended read Fbase_shipping_incl_tax write Fbase_shipping_incl_tax;
//Base currency code
  property Base_currency_code: String read Fbase_currency_code write Fbase_currency_code;
//Quote currency code
  property Quote_currency_code: String read Fquote_currency_code write Fquote_currency_code;
//Applied coupon code
  property Coupon_code: String read Fcoupon_code write Fcoupon_code;
//Items qty
  property Items_qty: Int64 read Fitems_qty write Fitems_qty;
//Totals by items
  property Items: TArray<TsgcOpenAPI_quote_data_totals_item_interface_Class> read Fitems write Fitems;
//Dynamically calculated totals
  property Total_segments: TArray<TsgcOpenAPI_quote_data_total_segment_interface_Class> read Ftotal_segments write Ftotal_segments;
  property Extension_attributes: TsgcOpenAPI_quote_data_totals_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Interface TotalsItemInterface
TsgcOpenAPI_quote_data_totals_item_interface_Class = class(TsgcOpenAPIClass)
private
  Fitem_id: Int64;
  Fprice: Extended;
  Fbase_price: Extended;
  Fqty: Extended;
  Frow_total: Extended;
  Fbase_row_total: Extended;
  Frow_total_with_discount: Extended;
  Ftax_amount: Extended;
  Fbase_tax_amount: Extended;
  Ftax_percent: Extended;
  Fdiscount_amount: Extended;
  Fbase_discount_amount: Extended;
  Fdiscount_percent: Extended;
  Fprice_incl_tax: Extended;
  Fbase_price_incl_tax: Extended;
  Frow_total_incl_tax: Extended;
  Fbase_row_total_incl_tax: Extended;
  Foptions: String;
  Fweee_tax_applied_amount: Extended;
  Fweee_tax_applied: String;
  Fextension_attributes: TsgcOpenAPI_quote_data_totals_item_extension_interface_Class;
  Fname: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_item_interface_Class;
public
//Item id
  property Item_id: Int64 read Fitem_id write Fitem_id;
//Item price in quote currency.
  property Price: Extended read Fprice write Fprice;
//Item price in base currency.
  property Base_price: Extended read Fbase_price write Fbase_price;
//Item quantity.
  property Qty: Extended read Fqty write Fqty;
//Row total in quote currency.
  property Row_total: Extended read Frow_total write Frow_total;
//Row total in base currency.
  property Base_row_total: Extended read Fbase_row_total write Fbase_row_total;
//Row total with discount in quote currency. Otherwise, null.
  property Row_total_with_discount: Extended read Frow_total_with_discount write Frow_total_with_discount;
//Tax amount in quote currency. Otherwise, null.
  property Tax_amount: Extended read Ftax_amount write Ftax_amount;
//Tax amount in base currency. Otherwise, null.
  property Base_tax_amount: Extended read Fbase_tax_amount write Fbase_tax_amount;
//Tax percent. Otherwise, null.
  property Tax_percent: Extended read Ftax_percent write Ftax_percent;
//Discount amount in quote currency. Otherwise, null.
  property Discount_amount: Extended read Fdiscount_amount write Fdiscount_amount;
//Discount amount in base currency. Otherwise, null.
  property Base_discount_amount: Extended read Fbase_discount_amount write Fbase_discount_amount;
//Discount percent. Otherwise, null.
  property Discount_percent: Extended read Fdiscount_percent write Fdiscount_percent;
//Price including tax in quote currency. Otherwise, null.
  property Price_incl_tax: Extended read Fprice_incl_tax write Fprice_incl_tax;
//Price including tax in base currency. Otherwise, null.
  property Base_price_incl_tax: Extended read Fbase_price_incl_tax write Fbase_price_incl_tax;
//Row total including tax in quote currency. Otherwise, null.
  property Row_total_incl_tax: Extended read Frow_total_incl_tax write Frow_total_incl_tax;
//Row total including tax in base currency. Otherwise, null.
  property Base_row_total_incl_tax: Extended read Fbase_row_total_incl_tax write Fbase_row_total_incl_tax;
//Item price in quote currency.
  property Options: String read Foptions write Foptions;
//Item weee tax applied amount in quote currency.
  property Weee_tax_applied_amount: Extended read Fweee_tax_applied_amount write Fweee_tax_applied_amount;
//Item weee tax applied in quote currency.
  property Weee_tax_applied: String read Fweee_tax_applied write Fweee_tax_applied;
  property Extension_attributes: TsgcOpenAPI_quote_data_totals_item_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Product name. Otherwise, null.
  property Name: String read Fname write Fname;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\TotalsItemInterface
TsgcOpenAPI_quote_data_totals_item_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_item_extension_interface_Class;
end;


//Description
//Interface TotalsInterface
TsgcOpenAPI_quote_data_total_segment_interface_Class = class(TsgcOpenAPIClass)
private
  Fcode: String;
  Ftitle: String;
  Fvalue: Extended;
  Farea: String;
  Fextension_attributes: TsgcOpenAPI_quote_data_total_segment_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_total_segment_interface_Class;
public
//Code
  property Code: String read Fcode write Fcode;
//Total title
  property Title: String read Ftitle write Ftitle;
//Total value
  property Value: Extended read Fvalue write Fvalue;
//Display area code.
  property Area: String read Farea write Farea;
  property Extension_attributes: TsgcOpenAPI_quote_data_total_segment_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\TotalSegmentInterface
TsgcOpenAPI_quote_data_total_segment_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Ftax_grandtotal_details: TArray<TsgcOpenAPI_tax_data_grand_total_details_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_total_segment_extension_interface_Class;
public
  property Tax_grandtotal_details: TArray<TsgcOpenAPI_tax_data_grand_total_details_interface_Class> read Ftax_grandtotal_details write Ftax_grandtotal_details;
end;


//Description
//Interface GrandTotalDetailsInterface
TsgcOpenAPI_tax_data_grand_total_details_interface_Class = class(TsgcOpenAPIClass)
private
  Famount: Extended;
  Frates: TArray<TsgcOpenAPI_tax_data_grand_total_rates_interface_Class>;
  Fgroup_id: Int64;
public
  class function Read(const aValue: string): TsgcOpenAPI_tax_data_grand_total_details_interface_Class;
public
//Tax amount value
  property Amount: Extended read Famount write Famount;
//Tax rates info
  property Rates: TArray<TsgcOpenAPI_tax_data_grand_total_rates_interface_Class> read Frates write Frates;
//Group identifier
  property Group_id: Int64 read Fgroup_id write Fgroup_id;
end;


//Description
//Interface GrandTotalRatesInterface
TsgcOpenAPI_tax_data_grand_total_rates_interface_Class = class(TsgcOpenAPIClass)
private
  Fpercent: String;
  Ftitle: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_tax_data_grand_total_rates_interface_Class;
public
//Tax percentage value
  property Percent: String read Fpercent write Fpercent;
//Rate title
  property Title: String read Ftitle write Ftitle;
end;


//Description
//ExtensionInterface class for @see \Magento\Quote\Api\Data\TotalsInterface
TsgcOpenAPI_quote_data_totals_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fcoupon_label: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_quote_data_totals_extension_interface_Class;
public
  property Coupon_label: String read Fcoupon_label write Fcoupon_label;
end;


//Description
//Interface ShippingInformationInterface
TsgcOpenAPI_checkout_data_shipping_information_interface_Class = class(TsgcOpenAPIClass)
private
  Fshipping_address: TsgcOpenAPI_quote_data_address_interface_Class;
  Fbilling_address: TsgcOpenAPI_quote_data_address_interface_Class;
  Fshipping_method_code: String;
  Fshipping_carrier_code: String;
  Fextension_attributes: TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_shipping_information_interface_Class;
public
  property Shipping_address: TsgcOpenAPI_quote_data_address_interface_Class read Fshipping_address write Fshipping_address;
  property Billing_address: TsgcOpenAPI_quote_data_address_interface_Class read Fbilling_address write Fbilling_address;
//Shipping method code
  property Shipping_method_code: String read Fshipping_method_code write Fshipping_method_code;
//Carrier code
  property Shipping_carrier_code: String read Fshipping_carrier_code write Fshipping_carrier_code;
  property Extension_attributes: TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Checkout\Api\Data\ShippingInformationInterface
TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class;
end;


//Description
//Interface PaymentDetailsInterface
TsgcOpenAPI_checkout_data_payment_details_interface_Class = class(TsgcOpenAPIClass)
private
  Fpayment_methods: TArray<TsgcOpenAPI_quote_data_payment_method_interface_Class>;
  Ftotals: TsgcOpenAPI_quote_data_totals_interface_Class;
  Fextension_attributes: TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_payment_details_interface_Class;
public
  property Payment_methods: TArray<TsgcOpenAPI_quote_data_payment_method_interface_Class> read Fpayment_methods write Fpayment_methods;
  property Totals: TsgcOpenAPI_quote_data_totals_interface_Class read Ftotals write Ftotals;
  property Extension_attributes: TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Checkout\Api\Data\PaymentDetailsInterface
TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class;
end;


//Description
//Interface TotalsInformationInterface
TsgcOpenAPI_checkout_data_totals_information_interface_Class = class(TsgcOpenAPIClass)
private
  Faddress: TsgcOpenAPI_quote_data_address_interface_Class;
  Fshipping_method_code: String;
  Fshipping_carrier_code: String;
  Fextension_attributes: TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class;
  Fcustom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_totals_information_interface_Class;
public
  property Address: TsgcOpenAPI_quote_data_address_interface_Class read Faddress write Faddress;
//Shipping method code
  property Shipping_method_code: String read Fshipping_method_code write Fshipping_method_code;
//Carrier code
  property Shipping_carrier_code: String read Fshipping_carrier_code write Fshipping_carrier_code;
  property Extension_attributes: TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class read Fextension_attributes write Fextension_attributes;
//Custom attributes values.
  property Custom_attributes: TArray<TsgcOpenAPI_framework_attribute_interface_Class> read Fcustom_attributes write Fcustom_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\Checkout\Api\Data\TotalsInformationInterface
TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class;
end;


//Description
//Search results for providing pickup locations.
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class = class(TsgcOpenAPIClass)
private
  Fitems: TArray<TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class>;
  Fsearch_request: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class;
  Ftotal_count: Int64;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class;
public
//Items list.
  property Items: TArray<TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class> read Fitems write Fitems;
  property Search_request: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class read Fsearch_request write Fsearch_request;
//Total count.
  property Total_count: Int64 read Ftotal_count write Ftotal_count;
end;


//Description
//Represents sources projection on In-Store Pickup context. Realisation must follow immutable DTO concept. Partial immutability done according to restriction of current Extension Attributes implementation.
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class = class(TsgcOpenAPIClass)
private
  Fpickup_location_code: String;
  Fname: String;
  Femail: String;
  Ffax: String;
  Fcontact_name: String;
  Fdescription: String;
  Flatitude: Extended;
  Flongitude: Extended;
  Fcountry_id: String;
  Fregion_id: Int64;
  Fregion: String;
  Fcity: String;
  Fstreet: String;
  Fpostcode: String;
  Fphone: String;
  Fextension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class;
public
//Source code of Pickup Location.
  property Pickup_location_code: String read Fpickup_location_code write Fpickup_location_code;
//Pickup Location name.
  property Name: String read Fname write Fname;
//Pickup Location contact email.
  property Email: String read Femail write Femail;
//Fax contact info.
  property Fax: String read Ffax write Ffax;
//Pickup Location contact name.
  property Contact_name: String read Fcontact_name write Fcontact_name;
//Pickup Location description.
  property Description: String read Fdescription write Fdescription;
//Pickup Location latitude.
  property Latitude: Extended read Flatitude write Flatitude;
//Pickup Location longitude.
  property Longitude: Extended read Flongitude write Flongitude;
//Pickup Location country ID.
  property Country_id: String read Fcountry_id write Fcountry_id;
//Pickup Location region ID.
  property Region_id: Int64 read Fregion_id write Fregion_id;
//Pickup Location region.
  property Region: String read Fregion write Fregion;
//Pickup Location city.
  property City: String read Fcity write Fcity;
//Pickup Location street.
  property Street: String read Fstreet write Fstreet;
//Pickup Location postcode.
  property Postcode: String read Fpostcode write Fpostcode;
//Pickup Location phone.
  property Phone: String read Fphone write Fphone;
  property Extension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\InventoryInStorePickupApi\Api\Data\PickupLocationInterface
TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class;
end;


//Description
//Endpoint used to search Pickup Locations by different parameters: - by attribute filters fields @see \Magento\InventoryInStorePickupApi\Api\Data\SearchRequest\FiltersInterface - by distance to the address @see \Magento\InventoryInStorePickupApi\Api\Data\SearchRequest\AreaInterface Also, endpoint supports paging and sort orders.
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class = class(TsgcOpenAPIClass)
private
  Farea: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class;
  Ffilters: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class;
  Fpage_size: Int64;
  Fcurrent_page: Int64;
  Fscope_type: String;
  Fscope_code: String;
  Fsort: TArray<TsgcOpenAPI_framework_sort_order_Class>;
  Fextension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class;
public
  property Area: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class read Farea write Farea;
  property Filters: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class read Ffilters write Ffilters;
//Page size.
  property Page_size: Int64 read Fpage_size write Fpage_size;
//Current page.
  property Current_page: Int64 read Fcurrent_page write Fcurrent_page;
//Sales Channel Type.
  property Scope_type: String read Fscope_type write Fscope_type;
//Sales Channel code.
  property Scope_code: String read Fscope_code write Fscope_code;
//Sort Order.
  property Sort: TArray<TsgcOpenAPI_framework_sort_order_Class> read Fsort write Fsort;
  property Extension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//Filter by Distance to the Address. Pickup Locations will be filtered by distance according to the geo-position of the entered address. Required fields for the address are country and one of the field: region or city or postcode.
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class = class(TsgcOpenAPIClass)
private
  Fradius: Int64;
  Fsearch_term: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class;
public
//Search radius in KM.
  property Radius: Int64 read Fradius write Fradius;
//Search term string.
  property Search_term: String read Fsearch_term write Fsearch_term;
end;


//Description
//Filter to filter by Fields. Each field may be filtered with different condition type. Supported condition types restricted by @see \Magento\Framework\Api\SearchCriteriaInterface
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class = class(TsgcOpenAPIClass)
private
  Fcountry: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fpostcode: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fregion: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fregion_id: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fcity: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fstreet: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fname: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
  Fpickup_location_code: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class;
public
  property Country: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fcountry write Fcountry;
  property Postcode: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fpostcode write Fpostcode;
  property Region: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fregion write Fregion;
  property Region_id: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fregion_id write Fregion_id;
  property City: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fcity write Fcity;
  property Street: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fstreet write Fstreet;
  property Name: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fname write Fname;
  property Pickup_location_code: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class read Fpickup_location_code write Fpickup_location_code;
end;


//Description
//Filter for Pickup Location search.
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class = class(TsgcOpenAPIClass)
private
  Fvalue: String;
  Fcondition_type: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
public
//Value.
  property Value: String read Fvalue write Fvalue;
//Condition Type.
  property Condition_type: String read Fcondition_type write Fcondition_type;
end;


//Description
//ExtensionInterface class for @see \Magento\InventoryInStorePickupApi\Api\Data\SearchRequestInterface
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class = class(TsgcOpenAPIClass)
private
  Fproducts_info: TArray<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class>;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class;
public
  property Products_info: TArray<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class> read Fproducts_info write Fproducts_info;
end;


//Description
//Product Info Data Transfer Object.
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class = class(TsgcOpenAPIClass)
private
  Fsku: String;
  Fextension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class;
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class;
public
//Product SKU.
  property Sku: String read Fsku write Fsku;
  property Extension_attributes: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class read Fextension_attributes write Fextension_attributes;
end;


//Description
//ExtensionInterface class for @see \Magento\InventoryInStorePickupApi\Api\Data\SearchRequest\ProductInfoInterface
TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class = class(TsgcOpenAPIClass)
public
  class function Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class;
end;


TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class = class(TsgcOpenAPIClass)
private
  Fcomment: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class;
public
  property Comment: String read Fcomment write Fcomment;
end;


//Description
//Interface AuthDataInterface
TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class = class(TsgcOpenAPIClass)
private
  Fclient_token: String;
  Fdisplay_name: String;
  Faction_success: String;
  Flogged_in: Boolean;
  Fstore_code: String;
public
  class function Read(const aValue: string): TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class;
public
//Client token
  property Client_token: String read Fclient_token write Fclient_token;
//Display name
  property Display_name: String read Fdisplay_name write Fdisplay_name;
//To success page
  property Action_success: String read Faction_success write Faction_success;
  property Logged_in: Boolean read Flogged_in write Flogged_in;
//Current store code
  property Store_code: String read Fstore_code write Fstore_code;
end;


TsgcOpenAPI_GetV1DirectoryCurrency_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_directory_data_currency_information_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_directory_data_currency_information_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_directory_data_country_information_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_directory_data_country_information_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_PostV1Customers_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_customer_data_customer_interface_Class;
  FError500: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_customer_data_customer_interface_Class read FSuccessful write FSuccessful;
  property Error500: TsgcOpenAPI_error_response_Class read FError500 write FError500;
end;


TsgcOpenAPI_GetV1Search_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_framework_search_search_result_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_framework_search_search_result_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1Productsrenderinfo_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1GuestcartsCartId_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_cart_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_cart_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_cart_item_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_cart_item_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_cart_item_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_cart_item_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_payment_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_payment_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_address_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_address_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_totals_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_totals_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_totals_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_totals_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_checkout_data_payment_details_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_checkout_data_payment_details_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_quote_data_totals_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_quote_data_totals_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_checkout_data_payment_details_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_checkout_data_payment_details_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_gift_message_data_message_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_gift_message_data_message_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_gift_message_data_message_interface_Class;
  FError400: TsgcOpenAPI_error_response_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_gift_message_data_message_interface_Class read FSuccessful write FSuccessful;
  property Error400: TsgcOpenAPI_error_response_Class read FError400 write FError400;
end;


TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_checkout_data_payment_details_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_checkout_data_payment_details_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_GetV1ApplepayAuth_Response = class(TsgcOpenAPIResponse)
private
  FSuccessful: TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class;
public
  destructor Destroy; override;
public
  property Successful: TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class read FSuccessful write FSuccessful;
end;


TsgcOpenAPI_error_errors_Array = class(TsgcOpenAPIArray)
private
  FItems: TArray<TsgcOpenAPI_error_errors_item_Class>;
protected
  procedure DoRead(aItem: Integer; const aValue: string); override;
public
  property Items: TArray<TsgcOpenAPI_error_errors_item_Class> read FItems write FItems;
end;


TsgcOpenAPI_error_parameters_Array = class(TsgcOpenAPIArray)
private
  FItems: TArray<TsgcOpenAPI_error_parameters_item_Class>;
protected
  procedure DoRead(aItem: Integer; const aValue: string); override;
public
  property Items: TArray<TsgcOpenAPI_error_parameters_item_Class> read FItems write FItems;
end;


{$ENDIF}

  function GetOpenAPIClient: sgcOpenAPI_schema;
  procedure FreeOpenAPIClient;


implementation

uses
  {$IFDEF SGC_OPENAPI_JSON} REST.Json,{$ENDIF} 
  sgcBase_Helpers;

var
  oOpenAPIClient: sgcOpenAPI_schema = nil;

function GetOpenAPIClient: sgcOpenAPI_schema;
begin
  if not Assigned(oOpenAPIClient)  then
    oOpenAPIClient := sgcOpenAPI_schema.Create(nil);
  result := oOpenAPIClient;
end;

procedure FreeOpenAPIClient;
begin
  FreeAndNil(oOpenAPIClient);
end;

constructor sgcOpenAPI_schema.Create(aOwner: TComponent);
begin
  inherited;
  FBaseURL := 'http://gestwin.biz/rest/all';
end;

procedure sgcOpenAPI_schema.SetServer0();
begin
  FBaseURL := 'http://gestwin.biz/rest/all';
end;


function sgcOpenAPI_schema._GetV1DirectoryCurrency(const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/directory/currency';


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Get currency information for the store.
function sgcOpenAPI_schema.GetV1DirectoryCurrency(): TsgcOpenAPI_GetV1DirectoryCurrency_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1DirectoryCurrency_Response.Create;
  _GetV1DirectoryCurrency(result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_directory_data_currency_information_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1DirectoryCurrency();
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1DirectoryCountries(const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/directory/countries';


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Get all countries and regions information for the store.
function sgcOpenAPI_schema.GetV1DirectoryCountries(): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1DirectoryCountries());
  {$ELSE}
  result := _GetV1DirectoryCountries();
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1DirectoryCountriesCountryId(aCountryId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/directory/countries/{countryId}';

    oRequest.Parameters.Add('countryId', aCountryId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Get country and region information for the store.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCountryId: </b>
function sgcOpenAPI_schema.GetV1DirectoryCountriesCountryId(aCountryId: string): TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response.Create;
  _GetV1DirectoryCountriesCountryId(aCountryId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_directory_data_country_information_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1DirectoryCountriesCountryId(aCountryId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1Customers(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/customers';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Create customer account. Perform necessary business operations like sending email.
function sgcOpenAPI_schema.PostV1Customers(const aBody: string): TsgcOpenAPI_PostV1Customers_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PostV1Customers_Response.Create;
  _PostV1Customers(aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_customer_data_customer_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      500: result.Error500 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _PostV1Customers(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken: string; aCustomerId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/customers/{customerId}/password/resetLinkToken/{resetPasswordLinkToken}';

    oRequest.Parameters.Add('customerId', aCustomerId, oapiInPath, true);
    oRequest.Parameters.Add('resetPasswordLinkToken', aResetPasswordLinkToken, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Check if password reset token is valid.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCustomerId: </b>
//If null is given then a customer will be matched by the RP token.
//
//
//<b>aResetPasswordLinkToken: </b>
function sgcOpenAPI_schema.GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken: string; aCustomerId: Int64 = 0): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken, aCustomerId));
  {$ELSE}
  result := _GetV1CustomersCustomerIdPasswordResetLinkTokenResetPasswordLinkToken(aResetPasswordLinkToken, aCustomerId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1CustomersPassword(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/customers/password';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Send an email to the customer with a password reset link.
function sgcOpenAPI_schema.PutV1CustomersPassword(const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PutV1CustomersPassword(aBody));
  {$ELSE}
  result := _PutV1CustomersPassword(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1CustomersResetPassword(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/customers/resetPassword';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Reset customer password.
function sgcOpenAPI_schema.PostV1CustomersResetPassword(const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1CustomersResetPassword(aBody));
  {$ELSE}
  result := _PostV1CustomersResetPassword(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1CustomersIsEmailAvailable(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/customers/isEmailAvailable';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Check if given email is associated with a customer account in given website.
function sgcOpenAPI_schema.PostV1CustomersIsEmailAvailable(const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1CustomersIsEmailAvailable(aBody));
  {$ELSE}
  result := _PostV1CustomersIsEmailAvailable(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1Search(aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aSearchCriteriarequestName: string = ''; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/search';

    oRequest.Parameters.Add('searchCriteria[requestName]', aSearchCriteriarequestName, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][field]', aSearchCriteriafilterGroups0filters0field, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][value]', aSearchCriteriafilterGroups0filters0value, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][conditionType]', aSearchCriteriafilterGroups0filters0conditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[sortOrders][0][field]', aSearchCriteriasortOrders0field, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[sortOrders][0][direction]', aSearchCriteriasortOrders0direction, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[pageSize]', aSearchCriteriapageSize, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[currentPage]', aSearchCriteriacurrentPage, oapiInQuery, false);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Make Full Text Search and return found Documents
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aSearchCriteriarequestName: </b>
//
//
//<b>aSearchCriteriafilterGroups0filters0field: </b>
//Field
//
//
//<b>aSearchCriteriafilterGroups0filters0value: </b>
//Value
//
//
//<b>aSearchCriteriafilterGroups0filters0conditionType: </b>
//Condition type
//
//
//<b>aSearchCriteriasortOrders0field: </b>
//Sorting field.
//
//
//<b>aSearchCriteriasortOrders0direction: </b>
//Sorting direction.
//
//
//<b>aSearchCriteriapageSize: </b>
//Page size.
//
//
//<b>aSearchCriteriacurrentPage: </b>
//Current page.
function sgcOpenAPI_schema.GetV1Search(aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aSearchCriteriarequestName: string = ''; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''
; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''): TsgcOpenAPI_GetV1Search_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1Search_Response.Create;
  _GetV1Search(aSearchCriteriapageSize, aSearchCriteriacurrentPage, aSearchCriteriarequestName, aSearchCriteriafilterGroups0filters0field, aSearchCriteriafilterGroups0filters0value, aSearchCriteriafilterGroups0filters0conditionType, aSearchCriteriasortOrders0field, aSearchCriteriasortOrders0direction, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_framework_search_search_result_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1Search(aSearchCriteriapageSize, aSearchCriteriacurrentPage, aSearchCriteriarequestName, aSearchCriteriafilterGroups0filters0field, aSearchCriteriafilterGroups0filters0value, aSearchCriteriafilterGroups0filters0conditionType, aSearchCriteriasortOrders0field, aSearchCriteriasortOrders0direction);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1Productsrenderinfo(aCurrencyCode: string; aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0; aStoreId: Int64 = 0; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/products-render-info';

    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][field]', aSearchCriteriafilterGroups0filters0field, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][value]', aSearchCriteriafilterGroups0filters0value, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[filterGroups][0][filters][0][conditionType]', aSearchCriteriafilterGroups0filters0conditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[sortOrders][0][field]', aSearchCriteriasortOrders0field, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[sortOrders][0][direction]', aSearchCriteriasortOrders0direction, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[pageSize]', aSearchCriteriapageSize, oapiInQuery, false);
    oRequest.Parameters.Add('searchCriteria[currentPage]', aSearchCriteriacurrentPage, oapiInQuery, false);
    oRequest.Parameters.Add('storeId', aStoreId, oapiInQuery, true);
    oRequest.Parameters.Add('currencyCode', aCurrencyCode, oapiInQuery, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Collect and retrieve the list of product render info. This info contains raw prices and formatted prices, product name, stock status, store_id, etc.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aSearchCriteriafilterGroups0filters0field: </b>
//Field
//
//
//<b>aSearchCriteriafilterGroups0filters0value: </b>
//Value
//
//
//<b>aSearchCriteriafilterGroups0filters0conditionType: </b>
//Condition type
//
//
//<b>aSearchCriteriasortOrders0field: </b>
//Sorting field.
//
//
//<b>aSearchCriteriasortOrders0direction: </b>
//Sorting direction.
//
//
//<b>aSearchCriteriapageSize: </b>
//Page size.
//
//
//<b>aSearchCriteriacurrentPage: </b>
//Current page.
//
//
//<b>aStoreId: </b>
//
//
//<b>aCurrencyCode: </b>
function sgcOpenAPI_schema.GetV1Productsrenderinfo(aCurrencyCode: string; aSearchCriteriapageSize: Int64 = 0; aSearchCriteriacurrentPage: Int64 = 0
; aStoreId: Int64 = 0; aSearchCriteriafilterGroups0filters0field: string = ''; aSearchCriteriafilterGroups0filters0value: string = ''; aSearchCriteriafilterGroups0filters0conditionType: string = ''; aSearchCriteriasortOrders0field: string = ''; aSearchCriteriasortOrders0direction: string = ''): TsgcOpenAPI_GetV1Productsrenderinfo_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1Productsrenderinfo_Response.Create;
  _GetV1Productsrenderinfo(aCurrencyCode, aSearchCriteriapageSize, aSearchCriteriacurrentPage, aStoreId, aSearchCriteriafilterGroups0filters0field, aSearchCriteriafilterGroups0filters0value, aSearchCriteriafilterGroups0filters0conditionType, aSearchCriteriasortOrders0field, aSearchCriteriasortOrders0direction, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1Productsrenderinfo(aCurrencyCode, aSearchCriteriapageSize, aSearchCriteriacurrentPage, aStoreId, aSearchCriteriafilterGroups0filters0field, aSearchCriteriafilterGroups0filters0value, aSearchCriteriafilterGroups0filters0conditionType, aSearchCriteriasortOrders0field, aSearchCriteriasortOrders0direction);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartId(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Enable a guest user to return information for a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.GetV1GuestcartsCartId(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartId_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartId_Response.Create;
  _GetV1GuestcartsCartId(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_cart_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1GuestcartsCartId(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1Guestcarts(const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts';


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Enable an customer or guest user to create an empty cart and quote for an anonymous customer.
function sgcOpenAPI_schema.PostV1Guestcarts(): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1Guestcarts());
  {$ELSE}
  result := _PostV1Guestcarts();
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdOrder(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/order';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Place an order for a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.PutV1GuestcartsCartIdOrder(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PutV1GuestcartsCartIdOrder(aCartId, aBody));
  {$ELSE}
  result := _PutV1GuestcartsCartIdOrder(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdShippingmethods(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/shipping-methods';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//List applicable shipping methods for a specified quote.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The shopping cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdShippingmethods(aCartId: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1GuestcartsCartIdShippingmethods(aCartId));
  {$ELSE}
  result := _GetV1GuestcartsCartIdShippingmethods(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdEstimateshippingmethods(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/estimate-shipping-methods';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Estimate shipping by address and return list of available shipping methods
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdEstimateshippingmethods(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdEstimateshippingmethods(aCartId, aBody));
  {$ELSE}
  result := _PostV1GuestcartsCartIdEstimateshippingmethods(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdItems(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/items';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//List items that are assigned to a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdItems(aCartId: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1GuestcartsCartIdItems(aCartId));
  {$ELSE}
  result := _GetV1GuestcartsCartIdItems(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdItems(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/items';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Add/update the specified cart item.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdItems(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response.Create;
  _PostV1GuestcartsCartIdItems(aCartId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_cart_item_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _PostV1GuestcartsCartIdItems(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/items/{itemId}';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);
    oRequest.Parameters.Add('itemId', aItemId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Add/update the specified cart item.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//
//
//<b>aItemId: </b>
function sgcOpenAPI_schema.PutV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response.Create;
  _PutV1GuestcartsCartIdItemsItemId(aCartId, aItemId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_cart_item_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _PutV1GuestcartsCartIdItemsItemId(aCartId, aItemId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._DeleteV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpDELETE;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/items/{itemId}';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);
    oRequest.Parameters.Add('itemId', aItemId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Remove the specified item from the specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
//
//
//<b>aItemId: </b>
//The item ID of the item to be removed.
function sgcOpenAPI_schema.DeleteV1GuestcartsCartIdItemsItemId(aCartId: string; aItemId: Int64 = 0): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_DeleteV1GuestcartsCartIdItemsItemId(aCartId, aItemId));
  {$ELSE}
  result := _DeleteV1GuestcartsCartIdItemsItemId(aCartId, aItemId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/selected-payment-method';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return the payment method for a specified shopping cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response.Create;
  _GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_payment_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1GuestcartsCartIdSelectedpaymentmethod(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/selected-payment-method';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Add a specified payment method to a specified shopping cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId, aBody));
  {$ELSE}
  result := _PutV1GuestcartsCartIdSelectedpaymentmethod(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdPaymentmethods(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/payment-methods';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//List available payment methods for a specified shopping cart. This call returns an array of objects, but detailed information about each object’s attributes might not be included.  See https://devdocs.magento.com/codelinks/attributes.html#GuestPaymentMethodManagementInterface to determine which call to use to get detailed information about all attributes for an object.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdPaymentmethods(aCartId: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1GuestcartsCartIdPaymentmethods(aCartId));
  {$ELSE}
  result := _GetV1GuestcartsCartIdPaymentmethods(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdBillingaddress(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/billing-address';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return the billing address for a specified quote.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdBillingaddress(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response.Create;
  _GetV1GuestcartsCartIdBillingaddress(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_address_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1GuestcartsCartIdBillingaddress(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdBillingaddress(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/billing-address';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Assign a specified billing address to a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.PostV1GuestcartsCartIdBillingaddress(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdBillingaddress(aCartId, aBody));
  {$ELSE}
  result := _PostV1GuestcartsCartIdBillingaddress(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdCoupons(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/coupons';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return information for a coupon in a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdCoupons(aCartId: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_GetV1GuestcartsCartIdCoupons(aCartId));
  {$ELSE}
  result := _GetV1GuestcartsCartIdCoupons(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._DeleteV1GuestcartsCartIdCoupons(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpDELETE;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/coupons';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Delete a coupon from a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.DeleteV1GuestcartsCartIdCoupons(aCartId: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_DeleteV1GuestcartsCartIdCoupons(aCartId));
  {$ELSE}
  result := _DeleteV1GuestcartsCartIdCoupons(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdCouponsCouponCode(aCartId: string; aCouponCode: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/coupons/{couponCode}';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);
    oRequest.Parameters.Add('couponCode', aCouponCode, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Add a coupon by code to a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
//
//
//<b>aCouponCode: </b>
//The coupon code data.
function sgcOpenAPI_schema.PutV1GuestcartsCartIdCouponsCouponCode(aCartId: string; aCouponCode: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PutV1GuestcartsCartIdCouponsCouponCode(aCartId, aCouponCode));
  {$ELSE}
  result := _PutV1GuestcartsCartIdCouponsCouponCode(aCartId, aCouponCode);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdCollecttotals(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/collect-totals';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Set shipping/billing methods and additional data for cart and collect totals for guest.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.PutV1GuestcartsCartIdCollecttotals(aCartId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response.Create;
  _PutV1GuestcartsCartIdCollecttotals(aCartId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_totals_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _PutV1GuestcartsCartIdCollecttotals(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdTotals(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/totals';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return quote totals data for a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdTotals(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response.Create;
  _GetV1GuestcartsCartIdTotals(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_totals_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1GuestcartsCartIdTotals(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1IntegrationAdminToken(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/integration/admin/token';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Create access token for admin given the admin credentials.
function sgcOpenAPI_schema.PostV1IntegrationAdminToken(const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1IntegrationAdminToken(aBody));
  {$ELSE}
  result := _PostV1IntegrationAdminToken(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1IntegrationCustomerToken(const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/integration/customer/token';
    oRequest.Body := aBody;


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Create access token for admin given the customer credentials.
function sgcOpenAPI_schema.PostV1IntegrationCustomerToken(const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1IntegrationCustomerToken(aBody));
  {$ELSE}
  result := _PostV1IntegrationCustomerToken(aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdShippinginformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/shipping-information';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdShippinginformation(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response.Create;
  _PostV1GuestcartsCartIdShippinginformation(aCartId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_checkout_data_payment_details_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _PostV1GuestcartsCartIdShippinginformation(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdTotalsinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/totals-information';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Calculate quote totals based on address and shipping method.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdTotalsinformation(aCartId: string; const aBody: string): TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response.Create;
  _PostV1GuestcartsCartIdTotalsinformation(aCartId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_quote_data_totals_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _PostV1GuestcartsCartIdTotalsinformation(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdPaymentinformation(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/payment-information';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Get payment information
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.GetV1GuestcartsCartIdPaymentinformation(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response.Create;
  _GetV1GuestcartsCartIdPaymentinformation(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_checkout_data_payment_details_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1GuestcartsCartIdPaymentinformation(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdPaymentinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/payment-information';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Set payment information and place order for a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdPaymentinformation(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdPaymentinformation(aCartId, aBody));
  {$ELSE}
  result := _PostV1GuestcartsCartIdPaymentinformation(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdSetpaymentinformation(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/set-payment-information';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Set payment information for a specified cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1GuestcartsCartIdSetpaymentinformation(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdSetpaymentinformation(aCartId, aBody));
  {$ELSE}
  result := _PostV1GuestcartsCartIdSetpaymentinformation(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdGiftmessage(aCartId: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/gift-message';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return the gift message for a specified order.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The shopping cart ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdGiftmessage(aCartId: string): TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response.Create;
  _GetV1GuestcartsCartIdGiftmessage(aCartId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_gift_message_data_message_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1GuestcartsCartIdGiftmessage(aCartId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdGiftmessage(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/gift-message';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Set the gift message for an entire order.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
function sgcOpenAPI_schema.PostV1GuestcartsCartIdGiftmessage(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdGiftmessage(aCartId, aBody));
  {$ELSE}
  result := _PostV1GuestcartsCartIdGiftmessage(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1GuestcartsCartIdGiftmessageItemId(aCartId: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/gift-message/{itemId}';

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);
    oRequest.Parameters.Add('itemId', aItemId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Return the gift message for a specified item in a specified shopping cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The shopping cart ID.
//
//
//<b>aItemId: </b>
//The item ID.
function sgcOpenAPI_schema.GetV1GuestcartsCartIdGiftmessageItemId(aCartId: string; aItemId: Int64 = 0): TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response.Create;
  _GetV1GuestcartsCartIdGiftmessageItemId(aCartId, aItemId, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_gift_message_data_message_interface_Class.Read(result.ResponseText)
  else
  begin
    case result.ResponseCode of
      400: result.Error400 := TsgcOpenAPI_error_response_Class.Read(result.ResponseError);
    end;
  end;
  {$ELSE}
  result := _GetV1GuestcartsCartIdGiftmessageItemId(aCartId, aItemId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1GuestcartsCartIdGiftmessageItemId(aCartId: string; const aBody: string; aItemId: Int64 = 0; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/gift-message/{itemId}';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);
    oRequest.Parameters.Add('itemId', aItemId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Set the gift message for a specified item in a specified shopping cart.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
//The cart ID.
//
//
//<b>aItemId: </b>
//The item ID.
function sgcOpenAPI_schema.PostV1GuestcartsCartIdGiftmessageItemId(aCartId: string; const aBody: string; aItemId: Int64 = 0): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1GuestcartsCartIdGiftmessageItemId(aCartId, aBody, aItemId));
  {$ELSE}
  result := _PostV1GuestcartsCartIdGiftmessageItemId(aCartId, aBody, aItemId);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius: Int64 = 0; aSearchRequestpageSize: Int64 = 0; aSearchRequestcurrentPage: Int64 = 0; aSearchRequestareasearchTerm: string = ''; aSearchRequestfilterscountryvalue: string = ''; aSearchRequestfilterscountryconditionType: string = ''; aSearchRequestfilterspostcodevalue: string = ''; aSearchRequestfilterspostcodeconditionType: string = ''; aSearchRequestfiltersregionvalue: string = ''; aSearchRequestfiltersregionconditionType: string = ''; aSearchRequestfiltersregionIdvalue: string = ''; aSearchRequestfiltersregionIdconditionType: string = ''; aSearchRequestfilterscityvalue: string = ''; aSearchRequestfilterscityconditionType: string = ''; aSearchRequestfiltersstreetvalue: string = ''; aSearchRequestfiltersstreetconditionType: string = ''; aSearchRequestfiltersnamevalue: string = ''; aSearchRequestfiltersnameconditionType: string = ''
; aSearchRequestfilterspickupLocationCodevalue: string = ''; aSearchRequestfilterspickupLocationCodeconditionType: string = ''; aSearchRequestscopeType: string = ''; aSearchRequestscopeCode: string = ''; aSearchRequestsort0field: string = ''; aSearchRequestsort0direction: string = ''; aSearchRequestextensionAttributesproductsInfo0sku: string = ''; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/inventory/in-store-pickup/pickup-locations/';

    oRequest.Parameters.Add('searchRequest[area][radius]', aSearchRequestarearadius, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[area][searchTerm]', aSearchRequestareasearchTerm, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][country][value]', aSearchRequestfilterscountryvalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][country][conditionType]', aSearchRequestfilterscountryconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][postcode][value]', aSearchRequestfilterspostcodevalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][postcode][conditionType]', aSearchRequestfilterspostcodeconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][region][value]', aSearchRequestfiltersregionvalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][region][conditionType]', aSearchRequestfiltersregionconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][regionId][value]', aSearchRequestfiltersregionIdvalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][regionId][conditionType]', aSearchRequestfiltersregionIdconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][city][value]', aSearchRequestfilterscityvalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][city][conditionType]', aSearchRequestfilterscityconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][street][value]', aSearchRequestfiltersstreetvalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][street][conditionType]', aSearchRequestfiltersstreetconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][name][value]', aSearchRequestfiltersnamevalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][name][conditionType]', aSearchRequestfiltersnameconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][pickupLocationCode][value]', aSearchRequestfilterspickupLocationCodevalue, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[filters][pickupLocationCode][conditionType]', aSearchRequestfilterspickupLocationCodeconditionType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[pageSize]', aSearchRequestpageSize, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[currentPage]', aSearchRequestcurrentPage, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[scopeType]', aSearchRequestscopeType, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[scopeCode]', aSearchRequestscopeCode, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[sort][0][field]', aSearchRequestsort0field, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[sort][0][direction]', aSearchRequestsort0direction, oapiInQuery, false);
    oRequest.Parameters.Add('searchRequest[extensionAttributes][productsInfo][0][sku]', aSearchRequestextensionAttributesproductsInfo0sku, oapiInQuery, false);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Get Pickup Locations according to the results of filtration by Search Request.
//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aSearchRequestarearadius: </b>
//Search radius in KM.
//
//
//<b>aSearchRequestareasearchTerm: </b>
//Search term string.
//
//
//<b>aSearchRequestfilterscountryvalue: </b>
//Value.
//
//
//<b>aSearchRequestfilterscountryconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfilterspostcodevalue: </b>
//Value.
//
//
//<b>aSearchRequestfilterspostcodeconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfiltersregionvalue: </b>
//Value.
//
//
//<b>aSearchRequestfiltersregionconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfiltersregionIdvalue: </b>
//Value.
//
//
//<b>aSearchRequestfiltersregionIdconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfilterscityvalue: </b>
//Value.
//
//
//<b>aSearchRequestfilterscityconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfiltersstreetvalue: </b>
//Value.
//
//
//<b>aSearchRequestfiltersstreetconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfiltersnamevalue: </b>
//Value.
//
//
//<b>aSearchRequestfiltersnameconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestfilterspickupLocationCodevalue: </b>
//Value.
//
//
//<b>aSearchRequestfilterspickupLocationCodeconditionType: </b>
//Condition Type.
//
//
//<b>aSearchRequestpageSize: </b>
//Page size.
//
//
//<b>aSearchRequestcurrentPage: </b>
//Current page.
//
//
//<b>aSearchRequestscopeType: </b>
//Sales Channel Type.
//
//
//<b>aSearchRequestscopeCode: </b>
//Sales Channel code.
//
//
//<b>aSearchRequestsort0field: </b>
//Sorting field.
//
//
//<b>aSearchRequestsort0direction: </b>
//Sorting direction.
//
//
//<b>aSearchRequestextensionAttributesproductsInfo0sku: </b>
//Product SKU.
function sgcOpenAPI_schema.GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius: Int64 = 0
; aSearchRequestpageSize: Int64 = 0; aSearchRequestcurrentPage: Int64 = 0; aSearchRequestareasearchTerm: string = ''; aSearchRequestfilterscountryvalue: string = ''; aSearchRequestfilterscountryconditionType: string = ''; aSearchRequestfilterspostcodevalue: string = ''; aSearchRequestfilterspostcodeconditionType: string = ''; aSearchRequestfiltersregionvalue: string = ''; aSearchRequestfiltersregionconditionType: string = ''; aSearchRequestfiltersregionIdvalue: string = ''; aSearchRequestfiltersregionIdconditionType: string = ''; aSearchRequestfilterscityvalue: string = ''; aSearchRequestfilterscityconditionType: string = ''; aSearchRequestfiltersstreetvalue: string = ''; aSearchRequestfiltersstreetconditionType: string = ''; aSearchRequestfiltersnamevalue: string = ''; aSearchRequestfiltersnameconditionType: string = ''; aSearchRequestfilterspickupLocationCodevalue: string = ''; aSearchRequestfilterspickupLocationCodeconditionType: string = ''
; aSearchRequestscopeType: string = ''; aSearchRequestscopeCode: string = ''; aSearchRequestsort0field: string = ''; aSearchRequestsort0direction: string = ''; aSearchRequestextensionAttributesproductsInfo0sku: string = ''): TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response.Create;
  _GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius, aSearchRequestpageSize, aSearchRequestcurrentPage, aSearchRequestareasearchTerm, aSearchRequestfilterscountryvalue, aSearchRequestfilterscountryconditionType, aSearchRequestfilterspostcodevalue, aSearchRequestfilterspostcodeconditionType, aSearchRequestfiltersregionvalue, aSearchRequestfiltersregionconditionType, aSearchRequestfiltersregionIdvalue, aSearchRequestfiltersregionIdconditionType, aSearchRequestfilterscityvalue, aSearchRequestfilterscityconditionType, aSearchRequestfiltersstreetvalue, aSearchRequestfiltersstreetconditionType, aSearchRequestfiltersnamevalue, aSearchRequestfiltersnameconditionType, aSearchRequestfilterspickupLocationCodevalue, aSearchRequestfilterspickupLocationCodeconditionType, aSearchRequestscopeType, aSearchRequestscopeCode, aSearchRequestsort0field, aSearchRequestsort0direction, aSearchRequestextensionAttributesproductsInfo0sku, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1InventoryInstorepickupPickuplocations(aSearchRequestarearadius, aSearchRequestpageSize, aSearchRequestcurrentPage, aSearchRequestareasearchTerm, aSearchRequestfilterscountryvalue, aSearchRequestfilterscountryconditionType, aSearchRequestfilterspostcodevalue, aSearchRequestfilterspostcodeconditionType, aSearchRequestfiltersregionvalue, aSearchRequestfiltersregionconditionType, aSearchRequestfiltersregionIdvalue, aSearchRequestfiltersregionIdconditionType, aSearchRequestfilterscityvalue, aSearchRequestfilterscityconditionType, aSearchRequestfiltersstreetvalue, aSearchRequestfiltersstreetconditionType, aSearchRequestfiltersnamevalue, aSearchRequestfiltersnameconditionType, aSearchRequestfilterspickupLocationCodevalue, aSearchRequestfilterspickupLocationCodeconditionType, aSearchRequestscopeType, aSearchRequestscopeCode, aSearchRequestsort0field, aSearchRequestsort0direction, aSearchRequestextensionAttributesproductsInfo0sku);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PutV1GuestcartsCartIdSetordercomment(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPUT;
    oRequest.Endpoint := '/V1/guest-carts/{cartId}/set-order-comment';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PutV1GuestcartsCartIdSetordercomment(aCartId: string; const aBody: string): TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response.Create;
  _PutV1GuestcartsCartIdSetordercomment(aCartId, aBody, result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_checkout_data_payment_details_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _PutV1GuestcartsCartIdSetordercomment(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._PostV1CartsCartIdUpdateorder(aCartId: string; const aBody: string; const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpPOST;
    oRequest.Endpoint := '/V1/carts/{cartId}/update-order';
    oRequest.Body := aBody;

    oRequest.Parameters.Add('cartId', aCartId, oapiInPath, true);

    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//
// <b><u>PARAMETERS</u></b>
//
//
//<b>aCartId: </b>
function sgcOpenAPI_schema.PostV1CartsCartIdUpdateorder(aCartId: string; const aBody: string): string;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := (_PostV1CartsCartIdUpdateorder(aCartId, aBody));
  {$ELSE}
  result := _PostV1CartsCartIdUpdateorder(aCartId, aBody);
  {$ENDIF}
end;

function sgcOpenAPI_schema._GetV1ApplepayAuth(const aResponse: TsgcOpenAPIResponse = nil): string;
var
  oRequest: TsgcOpenAPIRequest;
begin
  oRequest := TsgcOpenAPIRequest.Create;
  Try
    oRequest.Method := oapiHttpGET;
    oRequest.Endpoint := '/V1/applepay/auth';


    result := DoHTTP_REQUEST(oRequest, aResponse);
  Finally
    sgcFree(oRequest);
  end;
end;

//Description
//Returns details required to be able to submit a payment with apple pay.
function sgcOpenAPI_schema.GetV1ApplepayAuth(): TsgcOpenAPI_GetV1ApplepayAuth_Response;
begin;
  {$IFDEF SGC_OPENAPI_JSON}
  result := TsgcOpenAPI_GetV1ApplepayAuth_Response.Create;
  _GetV1ApplepayAuth(result);
  if result.IsSuccessful then 
    result.Successful := TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class.Read(result.ResponseText)
  {$ELSE}
  result := _GetV1ApplepayAuth();
  {$ENDIF}
end;

{$IFDEF SGC_OPENAPI_JSON}
class function TsgcOpenAPI_error_response_Class.Read(const aValue: string): TsgcOpenAPI_error_response_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_error_response_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_error_errors_item_Class.Read(const aValue: string): TsgcOpenAPI_error_errors_item_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_error_errors_item_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_error_parameters_item_Class.Read(const aValue: string): TsgcOpenAPI_error_parameters_item_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_error_parameters_item_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_currency_information_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_currency_information_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_currency_information_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_exchange_rate_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_exchange_rate_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_exchange_rate_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_exchange_rate_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_currency_information_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_currency_information_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_currency_information_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_country_information_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_country_information_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_country_information_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_region_information_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_region_information_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_region_information_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_region_information_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_region_information_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_region_information_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_directory_data_country_information_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_directory_data_country_information_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_directory_data_country_information_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_customer_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_customer_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_customer_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_address_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_address_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_address_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_region_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_region_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_region_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_region_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_region_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_region_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_address_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_address_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_address_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_attribute_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_attribute_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_attribute_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_customer_data_customer_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_customer_data_customer_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_customer_data_customer_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_search_result_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_search_result_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_search_result_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_document_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_document_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_document_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_aggregation_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_aggregation_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_aggregation_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_bucket_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_bucket_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_bucket_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_aggregation_value_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_aggregation_value_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_aggregation_value_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_search_criteria_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_search_criteria_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_search_criteria_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_search_filter_group_Class.Read(const aValue: string): TsgcOpenAPI_framework_search_filter_group_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_search_filter_group_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_filter_Class.Read(const aValue: string): TsgcOpenAPI_framework_filter_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_filter_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_sort_order_Class.Read(const aValue: string): TsgcOpenAPI_framework_sort_order_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_sort_order_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_search_results_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_button_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_button_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_button_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_button_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_price_info_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_formatted_price_info_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_formatted_price_info_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_price_info_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class.Read(const aValue: string): TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_msrp_data_product_render_msrp_price_info_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_msrp_data_product_render_msrp_price_info_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class.Read(const aValue: string): TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_weee_data_product_render_weee_adjustment_attribute_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_image_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_image_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_image_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_image_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_product_render_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_product_render_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_product_render_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_cart_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_cart_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_cart_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_cart_item_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_cart_item_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_cart_item_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_product_option_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_product_option_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_product_option_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_product_option_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_product_option_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_product_option_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_custom_option_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_custom_option_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_custom_option_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_catalog_data_custom_option_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_framework_data_image_content_interface_Class.Read(const aValue: string): TsgcOpenAPI_framework_data_image_content_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_framework_data_image_content_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class.Read(const aValue: string): TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_downloadable_data_downloadable_option_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_bundle_data_bundle_option_interface_Class.Read(const aValue: string): TsgcOpenAPI_bundle_data_bundle_option_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_bundle_data_bundle_option_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_bundle_data_bundle_option_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class.Read(const aValue: string): TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_grouped_product_data_grouped_options_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_grouped_product_data_grouped_options_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class.Read(const aValue: string): TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_configurable_product_data_configurable_item_option_value_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_configurable_product_data_configurable_item_option_value_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_cart_item_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_cart_item_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_cart_item_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class.Read(const aValue: string): TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_sales_rule_data_rule_discount_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_sales_rule_data_discount_data_interface_Class.Read(const aValue: string): TsgcOpenAPI_sales_rule_data_discount_data_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_sales_rule_data_discount_data_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_address_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_address_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_address_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_address_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_address_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_address_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_currency_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_currency_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_currency_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_currency_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_currency_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_currency_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_cart_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_cart_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_cart_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_assignment_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_assignment_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_assignment_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_assignment_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_payment_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_payment_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_payment_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_payment_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_payment_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_payment_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_method_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_method_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_method_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_shipping_method_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_payment_method_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_payment_method_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_payment_method_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_additional_data_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_additional_data_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_additional_data_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_additional_data_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_gift_message_data_message_interface_Class.Read(const aValue: string): TsgcOpenAPI_gift_message_data_message_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_gift_message_data_message_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_gift_message_data_message_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_gift_message_data_message_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_gift_message_data_message_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_item_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_item_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_item_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_item_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_item_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_item_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_total_segment_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_total_segment_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_total_segment_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_total_segment_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_total_segment_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_total_segment_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_tax_data_grand_total_details_interface_Class.Read(const aValue: string): TsgcOpenAPI_tax_data_grand_total_details_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_tax_data_grand_total_details_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_tax_data_grand_total_rates_interface_Class.Read(const aValue: string): TsgcOpenAPI_tax_data_grand_total_rates_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_tax_data_grand_total_rates_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_quote_data_totals_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_quote_data_totals_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_quote_data_totals_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_shipping_information_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_shipping_information_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_shipping_information_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_shipping_information_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_payment_details_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_payment_details_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_payment_details_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_payment_details_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_totals_information_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_totals_information_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_totals_information_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_checkout_data_totals_information_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_result_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_pickup_location_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_area_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filters_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_filter_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class.Read(const aValue: string): TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_inventory_in_store_pickup_api_data_search_request_product_info_extension_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class.Read(const aValue: string): TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_gestwin_order_comment_data_order_comment_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

class function TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class.Read(const aValue: string): TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class;
begin
  result := TJson.JsonToObject<TsgcOpenAPI_pay_pal_braintree_data_auth_data_interface_Class>(aValue);
  result.SetRawText(aValue);
end;

destructor TsgcOpenAPI_GetV1DirectoryCurrency_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1DirectoryCountriesCountryId_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_PostV1Customers_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError500);
  inherited;
end;


destructor TsgcOpenAPI_GetV1Search_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1Productsrenderinfo_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartId_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_PostV1GuestcartsCartIdItems_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_PutV1GuestcartsCartIdItemsItemId_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdSelectedpaymentmethod_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdBillingaddress_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_PutV1GuestcartsCartIdCollecttotals_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdTotals_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_PostV1GuestcartsCartIdShippinginformation_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_PostV1GuestcartsCartIdTotalsinformation_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdPaymentinformation_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessage_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1GuestcartsCartIdGiftmessageItemId_Response.Destroy;
begin
  sgcFree(FSuccessful);
  sgcFree(FError400);
  inherited;
end;


destructor TsgcOpenAPI_GetV1InventoryInstorepickupPickuplocations_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_PutV1GuestcartsCartIdSetordercomment_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


destructor TsgcOpenAPI_GetV1ApplepayAuth_Response.Destroy;
begin
  sgcFree(FSuccessful);
  inherited;
end;


procedure TsgcOpenAPI_error_errors_Array.DoRead(aItem: Integer; const aValue: string);
begin
  Items[aItem] := TJson.JsonToObject<TsgcOpenAPI_error_errors_item_Class>(aValue);
end;

procedure TsgcOpenAPI_error_parameters_Array.DoRead(aItem: Integer; const aValue: string);
begin
  Items[aItem] := TJson.JsonToObject<TsgcOpenAPI_error_parameters_item_Class>(aValue);
end;

{$ENDIF}

initialization

finalization
  FreeOpenAPIClient;
end.
