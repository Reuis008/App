// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/outline_view.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/search_view.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/thumbnails_view.dart';

import 'package:pdfrx/pdfrx.dart';

class PdfRender extends StatefulWidget {
  final String pdfName;
  final String pdfPath;
  final String pdfType;
  const PdfRender(
      {super.key,
      required this.pdfName,
      required this.pdfPath,
      required this.pdfType});

  @override
  State<PdfRender> createState() => _PdfRenderState();
}

class _PdfRenderState extends State<PdfRender> {
  final documentRef = ValueNotifier<PdfDocumentRef?>(null);
  final controller = PdfViewerController();
  final showLeftPane = ValueNotifier<bool>(false);
  final outline = ValueNotifier<List<PdfOutlineNode>?>(null);
  late final textSearcher = PdfTextSearcher(controller)..addListener(_update);
  Uint8List? data;
  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    if (widget.pdfType == "data") {
      _loadPdfData();
    }
    super.initState();
  }

  Future<void> _loadPdfData() async {
    var pdfFile = File(widget.pdfPath);

    if (await pdfFile.exists()) {
      String pdfContent = pdfFile.readAsStringSync();
      data = base64Decode(pdfContent);
    }
  }

  @override
  void dispose() {
    textSearcher.removeListener(_update);
    textSearcher.dispose();
    showLeftPane.dispose();
    outline.dispose();
    documentRef.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30.sp,
          ),
          onPressed: () {
            showLeftPane.value = !showLeftPane.value;
          },
        ),
        title: Text(widget.pdfName),
        toolbarHeight: 100.h,
        actions: [
          IconButton(
            icon: Icon(
              Icons.zoom_in,
              size: 30.sp,
            ),
            onPressed: () => controller.zoomUp(),
          ),
          IconButton(
            icon: Icon(
              Icons.zoom_out,
              size: 30.sp,
            ),
            onPressed: () => controller.zoomDown(),
          ),
          IconButton(
            icon: Icon(
              Icons.first_page,
              size: 30.sp,
            ),
            onPressed: () => controller.goToPage(pageNumber: 1),
          ),
          IconButton(
            icon: Icon(
              Icons.last_page,
              size: 30.sp,
            ),
            onPressed: () =>
                controller.goToPage(pageNumber: controller.pages.length),
          ),
        ],
      ),
      body: Row(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: ValueListenableBuilder(
              valueListenable: showLeftPane,
              builder: (context, showLeftPane, child) => SizedBox(
                width: showLeftPane ? 300 : 0,
                child: child!,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 4, 0),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(icon: Icon(Icons.search), text: 'Search'),
                        Tab(icon: Icon(Icons.menu_book), text: 'TOC'),
                        Tab(icon: Icon(Icons.image), text: 'Pages'),
                      ]),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // NOTE: documentRef is not explicitly used but it indicates that
                            // the document is changed.
                            ValueListenableBuilder(
                              valueListenable: documentRef,
                              builder: (context, documentRef, child) =>
                                  TextSearchView(
                                textSearcher: textSearcher,
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: outline,
                              builder: (context, outline, child) => OutlineView(
                                outline: outline,
                                controller: controller,
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: documentRef,
                              builder: (context, documentRef, child) =>
                                  ThumbnailsView(
                                documentRef: documentRef,
                                controller: controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                widget.pdfType == "data" && data != null
                    ? PdfViewer.data(
                        data!,
                        sourceName: widget.pdfPath,
                        controller: controller,
                        params: PdfViewerParams(
                          errorBannerBuilder:
                              (context, error, stackTrace, documentRef) {
                            return const Center(
                              child: Text('Failed to load PDF document'),
                            );
                          },
                          // enableTextSelection: true,
                          maxScale: 8,

                          viewerOverlayBuilder: (context, size) => [
                            // Show vertical scroll thumb on the right; it has page number on it
                            PdfViewerScrollThumb(
                              controller: controller,
                              orientation: ScrollbarOrientation.right,
                              thumbSize: const Size(40, 25),
                              thumbBuilder: (context, thumbSize, pageNumber,
                                      controller) =>
                                  Container(
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    pageNumber.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            // Just a simple horizontal scroll thumb on the bottom
                            PdfViewerScrollThumb(
                              controller: controller,
                              orientation: ScrollbarOrientation.bottom,
                              thumbSize: const Size(80, 30),
                              thumbBuilder: (context, thumbSize, pageNumber,
                                      controller) =>
                                  Container(
                                color: Colors.red,
                              ),
                            ),
                          ],
                          //
                          // Loading progress indicator example
                          //
                          loadingBannerBuilder:
                              (context, bytesDownloaded, totalBytes) => Center(
                            child: CircularProgressIndicator(
                              value: totalBytes != null
                                  ? bytesDownloaded / totalBytes
                                  : null,
                              backgroundColor: Colors.grey,
                            ),
                          ),

                          onViewerReady: (document, controller) async {
                            documentRef.value = controller.documentRef;
                            outline.value = await document.loadOutline();
                          },
                        ),
                      )
                    : widget.pdfType != "data" && widget.pdfPath != null
                        ? PdfViewer.asset(
                            widget.pdfPath,
                            controller: controller,
                            params: PdfViewerParams(
                              errorBannerBuilder:
                                  (context, error, stackTrace, documentRef) {
                                return const Center(
                                    child: Text('Failed to load PDF document'));
                              },
                              // enableTextSelection: true,
                              maxScale: 8,

                              viewerOverlayBuilder: (context, size) => [
                                // Show vertical scroll thumb on the right; it has page number on it
                                PdfViewerScrollThumb(
                                  controller: controller,
                                  orientation: ScrollbarOrientation.right,
                                  thumbSize: const Size(40, 25),
                                  thumbBuilder: (context, thumbSize, pageNumber,
                                          controller) =>
                                      Container(
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        pageNumber.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                // Just a simple horizontal scroll thumb on the bottom
                                PdfViewerScrollThumb(
                                  controller: controller,
                                  orientation: ScrollbarOrientation.bottom,
                                  thumbSize: const Size(80, 30),
                                  thumbBuilder: (context, thumbSize, pageNumber,
                                          controller) =>
                                      Container(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                              //
                              // Loading progress indicator example
                              //
                              loadingBannerBuilder:
                                  (context, bytesDownloaded, totalBytes) =>
                                      Center(
                                child: CircularProgressIndicator(
                                  value: totalBytes != null
                                      ? bytesDownloaded / totalBytes
                                      : null,
                                  backgroundColor: Colors.grey,
                                ),
                              ),

                              onViewerReady: (document, controller) async {
                                documentRef.value = controller.documentRef;
                                outline.value = await document.loadOutline();
                              },
                            ),
                          )
                        : const Center(
                            child: Text('PDF data is not available.'),
                          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
