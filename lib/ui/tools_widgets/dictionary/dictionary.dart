import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/dictionary/api.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/dictionary/response_model.dart';
import 'package:lottie/lottie.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  bool inProgress = false;
  ResponseModel? responseModel;
  String noDataText = "Welcome, Start searching";
  TextEditingController _textController = TextEditingController();
  bool _showClearButton = false;
  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _textController.text.isNotEmpty;
    });
  }

  void _clearText() {
    _textController.clear();
    setState(() {
      _showClearButton = false;
      noDataText = "Welcome, Start searching";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.outline,
            size: MediaQuery.of(context).size.width < 600 ? 40.sp : 32.sp,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSearchWidget(),
                SizedBox(height: 12.h),
                if (inProgress)
                  const LinearProgressIndicator()
                else if (responseModel != null)
                  Expanded(
                      child: !_showClearButton
                          ? _noDataWidget()
                          : _buildResponseWidget())
                else
                  _noDataWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildResponseWidget() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          Text(
            ' Looking for : ${responseModel!.word}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildMeaningWidget(responseModel!.meanings[index]);
            },
            itemCount: responseModel!.meanings.length,
          ))
        ],
      ),
    );
  }

  _buildMeaningWidget(Meanings meanings) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              meanings.speechPart,
              style: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "Definition : ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(meanings.def),
            SizedBox(height: 10.h),
            Text(
              "Example : ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            Text(meanings.example ?? 'No example available'),
            _buildSet("Synonyms", meanings.synonyms),
          ],
        ),
      ),
    );
  }

  _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title : ",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(setList!
              .toSet()
              .toString()
              .replaceAll("{", "")
              .replaceAll("}", "")),
          SizedBox(height: 10.h),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _noDataWidget() {
    return SizedBox(
      height: 700,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: Lottie.asset('assets/json/search.json'),
            ),
            Text(
              noDataText,
              style: TextStyle(fontSize: 18.sp, color: Colors.deepOrangeAccent),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _buildSearchWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        autocorrect: true,
        enableSuggestions: true,
        controller: _textController,
        style: TextStyle(
            color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w400),
        onChanged: (value) {
          _getMeaningFromApi(value);
        },
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30.sp,
            ),
          ),
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: _clearText,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  _getMeaningFromApi(String word) async {
    setState(() {
      inProgress = true;
    });
    try {
      responseModel = await API.fetchMeaning(word);

      setState(() {});
    } catch (e) {
      responseModel = null;
      noDataText = "Meaning cannot be fetched";
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
