/*
 * Copyright 2007-2011 the original author or authors.
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
part of stagexl_spring;

/**
	 * <p><code>KeyValuePropertiesParser</code> parses a properties source string into a <code>IPropertiesProvider</code>
	 * instance.</p>
	 *
	 * <p>The source string contains simple key-value pairs. Multiple pairs are
	 * separated by line terminators (\n or \r or \r\n). Keys are separated from
	 * values with the characters '=', ':' or a white space character.</p>
	 *
	 * <p>Comments are also supported. Just add a '#' or '!' character at the
	 * beginning of your comment-line.</p>
	 *
	 * <p>If you want to use any of the special characters in your key or value you
	 * must escape it with a back-slash character '\'.</p>
	 *
	 * <p>The key contains all of the characters in a line starting from the first
	 * non-white space character up to, but not including, the first unescaped
	 * key-value-separator.</p>
	 *
	 * <p>The value contains all of the characters in a line starting from the first
	 * non-white space character after the key-value-separator up to the end of the
	 * line. You may of course also escape the line terminator and create a value
	 * across multiple lines.</p>
	 *
	 * @see org.springextensions.actionscript.collections.Properties Properties
	 *
	 * @author Martin Heidegger
	 * @author Simon Wacker
	 * @author Christophe Herreman
	 * @version 1.0
	 */
class KeyValuePropertiesParser implements IPropertiesParser {
  static const int HASH_CHARCODE = 35; //= "#";
  static const int EXCLAMATION_MARK_CHARCODE = 33; //= "!";
  static const String DOUBLE_BACKWARD_SLASH = '\\';
  static const String NEWLINE_CHAR = "\n";
  static final RegExp NEWLINE_REGEX = new RegExp(r'\\n'); // /\\n/gm;
  static final Logger logger = new Logger("KeyValuePropertiesParser");

  /**
		 * Constructs a new <code>PropertiesParser</code> instance.
		 */
  KeyValuePropertiesParser() : super() {}

  /**
		 * Parses the given <code>source</code> and creates a <code>Properties</code> instance from it.
		 *
		 * @param source the source to parse
		 * @return the properties defined by the given <code>source</code>
		 */
  void parseProperties(dynamic source, IPropertiesProvider provider) {
    logger.finer("Parsing properties sources:");
    MultilineString lines = new MultilineString((source.toString()));
    num numLines = lines.numLines;
    String key = "";
    String value = "";
    String formerKey = "";
    String formerValue = "";
    bool useNextLine = false;

    for (int i = 0; i < numLines; i++) {
      String line = lines.getLine(i);
      //logger.finer("Parsing line: {0}", [line]);
      // Trim the line
      line = StringUtils.trim(line);

      // Ignore Comments and empty lines
      if (isPropertyLine(line)) {
        // Line break processing
        if (useNextLine) {
          key = formerKey;
          value = formerValue + line;
          useNextLine = false;
        } else {
          int sep = line.indexOf("=");
          key = StringUtils.rightTrim(line.substring(0, sep));
          value = line.substring(sep + 1);
          formerKey = key;
          formerValue = value;
        }
        // Trim the content
        value = StringUtils.leftTrim(value);

        // Allow normal lines
        String end = value == "" ? "" : value.substring(value.length - 1);
        if (end == DOUBLE_BACKWARD_SLASH) {
          formerValue = value = value.substring(0, value.length - 1);
          useNextLine = true;
        } else {
          // restore newlines since these were escaped when loaded
          value = value.replaceAll(NEWLINE_REGEX, NEWLINE_CHAR);
          provider.setProperty(key, value);
        }
      } else {
        //logger.finer("Ignoring commented line.");
      }
    }
  }

  bool isPropertyLine(String line) {
    return (line != null &&
        line.length > 0 &&
        line.codeUnitAt(0) != HASH_CHARCODE &&
        line.codeUnitAt(0) != EXCLAMATION_MARK_CHARCODE &&
        line.length != 0);
  }
}
