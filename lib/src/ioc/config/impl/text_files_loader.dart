/*
 * Copyright 2007-2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
part of rockdot_spring;

/**
	 * Loads 1 or more text files.
	 *
	 * @author Roland Zwaga
	 * @author Christophe Herreman
	 */
class TextFilesLoader extends OperationQueue implements ITextFilesLoader {
  static const String QUESTION_MARK = '?';
  static const String AMPERSAND = "&";

  Logger logger;

  List<IOperation> _requiredOperations;
  List<String> _results;
  IOperation _failedOperation;

  /**
		 * Creates a new <code>TextFilesLoader</code> instance.
		 * @param name An optional name for the current <code>TextFilesLoader</code>.
		 */
  TextFilesLoader([String name = ""]) : super(name) {
    logger = new Logger("TextFilesLoader");
    _results = new List<String>();
    _requiredOperations = new List<IOperation>();
  }

  /**
		 * @inheritDoc
		 */
  void addURIs(List<TextFileURI> uris) {
    for (TextFileURI propertyURI in uris) {
      addURI(propertyURI.textFileURI, propertyURI.preventCache, propertyURI.isRequired);
    }
  }

  /**
		 * @inheritDoc
		 */
  void addURI(String uri, [bool preventCache = true, bool isRequired = true]) {
    LoadURLOperation loadOperation = new LoadURLOperation(name, formatURL(uri, preventCache));
    if (isRequired != null) {
      _requiredOperations.add(loadOperation);
    }
    loadOperation.addCompleteListener(textFileLoaderComplete);
    loadOperation.addErrorListener(textFileLoaderError);
    addOperation(loadOperation);
    logger.finer("Added URI '{0}', with preventCache:{1} and isRequired:{2}", [uri, preventCache, isRequired]);
  }

  /**
		 * @inheritDoc
		 */
  @override
  bool dispatchCompleteEvent([dynamic result = null]) {
    logger.finer("Completed loading of {0} text file(s)", [_results.length]);
    return super.dispatchCompleteEvent(_results);
  }

  @override
  bool dispatchErrorEvent([dynamic error = null]) {
    if (isRequired(_failedOperation)) {
      return super.dispatchErrorEvent(error);
    }
    return false;
  }

  bool isRequired(IOperation operation) {
    return (_requiredOperations.indexOf(operation) > -1);
  }

  void textFileLoaderComplete(OperationEvent event) {
    cleanUpLoadURLOperation(event.operation);
    _results.add((event.result.toString()));
    logger.finer("Completed operation {0}", [event.operation]);
  }

  void textFileLoaderError(OperationEvent event) {
    _failedOperation = event.operation;
    cleanUpLoadURLOperation(event.operation);
    logger.severe("Failed to load {0}", [(event.operation as LoadURLOperation).url]);
  }

  /**
		 *
		 * @param operation
		 */
  void cleanUpLoadURLOperation(IOperation operation) {
    operation.removeCompleteListener(textFileLoaderComplete);
    operation.removeErrorListener(textFileLoaderError);
  }

  /**
		 * Adds a random number to the url, checks if a '?' character is already part of the string
		 * than suffixes a '&amp;' character
		 * @param url The url that will be processed
		 * @param preventCache
		 * @return The formatted URL
		 */
  static String formatURL(String url, bool preventCache) {
    if (preventCache != null) {
      String parameterAppendChar = (url.indexOf(QUESTION_MARK) < 0) ? QUESTION_MARK : AMPERSAND;
      url += (parameterAppendChar + (new Random().nextDouble() * 1000000).round().toString());
    }
    return url;
  }
}
