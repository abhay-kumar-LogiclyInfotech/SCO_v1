import 'dart:convert';
import 'dart:developer';

import 'package:delightful_toast/toast/components/raw_delight_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/components/custom_simple_app_bar.dart';
import '../../../viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import '../../../viewModel/get_page_content_by_urls_viewModels/Internal/get_page_content_by_url_viewModel.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WebView extends StatefulWidget {
  final String url;
  final String scholarshipType;

  const WebView({super.key, required this.url, required this.scholarshipType});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late NavigationServices _navigationServices;
  late final WebViewController controller;
  var loadingPercentage = 0;

  void hideHeaderAndFooter() {
    controller.runJavaScript("""
  const header = document.querySelector('#banner');
  if (header) {
    header.style.display = 'none';
  }

  const footer = document.querySelector('#footer-section-outer');
  if (footer) {
    footer.style.display = 'none';
  }
  
   const side = document.querySelector('#column-1');
  if (side) {
    side.style.display = 'none';
  }
  
     const title = document.querySelector('#p_p_id_com_liferay_site_navigation_breadcrumb_web_portlet_SiteNavigationBreadcrumbPortlet_');
  if (title) {
    title.style.display = 'none';
  }
  
  const adsSection = document.querySelector('.ads-section');
  if (adsSection) {
    adsSection.style.display = 'none';
  }
""");
  }

  bool _isLoading = false;

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationServices = getIt.get<NavigationServices>();
    // Validate URL
    if (_isValidUrl(widget.url)) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url))
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              _isLoading = true;
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            hideHeaderAndFooter();
            setState(() {
              _isLoading = false;
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (error) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Failed to load the page: ${error.description}')),
            );
          },
        ));
    } else {
      // Handle invalid URL
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid URL provided')),
        );
      });
    }
    super.initState();
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
          titleAsString: getScholarshipTypeText(widget.scholarshipType,localization)),
      body: _isValidUrl(widget.url)
          ? Stack(children: [
              _isLoading
                  ? Utils.pageLoadingIndicator(context: context)
                  : Consumer<GetPageContentByUrlViewModel>(
                      builder: (context, provider, _) {
                      return WebViewWidget(
                        controller: controller,
                      );
                    }),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  backgroundColor: AppColors.scoLightThemeColor,
                  color: AppColors.scoThemeColor,
                  value: loadingPercentage / 100.0,
                ),
            ])
          : Center(
              child: Text(
                localization.something_went_wrong,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
    );
  }

  String getScholarshipTypeText(
      String scholarshipType, AppLocalizations localization) {
    switch (scholarshipType) {
      case 'EXT':
        return localization.scholarshipTypeExternal;
      case 'INT':
        return localization.scholarshipTypeInternal;
      case 'UGRDINT':
        return localization.internalBachelor;
      case 'PGRDINT':
        return localization.internalPostgraduate;
      case 'METLOGINT':
        return localization.internalMeterological;
        case 'UGRDEXT':
        return localization.externalBachelor;
        case 'PGRDEXT':
        return localization.externalPostgraduate;
      case 'DDSEXT':
        return localization.externalDoctors;
      default:
        return 'Unknown Type'; // Return a default value if the type does not match
    }
  }
}
