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
part of acanvas_spring;

/**
	 * <code>MultilineString</code> allows to access all lines of a string separately.
	 *
	 * <p>To not have to deal with different forms of line breaks (Windows/Apple/Unix)
	 * <code>MultilineString</code> automatically standardizes them to the <code>\n</code> character.
	 * So the passed-in <code>String</code> will always get standardized.</p>
	 *
	 * <p>If you need to access the original <code>String</code> you can use
	 * <code>getOriginalString</code>.</p>
	 *
	 * @author Martin Heidegger, Christophe Herreman
	 * @version 1.0
	 */
class MultilineString {
  /** Character code for the WINDOWS line break. */
  static final String WIN_BREAK = new String.fromCharCodes([13]) + new String.fromCharCodes([10]);

  /** Character code for the APPLE line break. */
  static final String MAC_BREAK = new String.fromCharCodes([13]);
  /** Character used internally for line breaks. */
  static const String NEWLINE_CHAR = "\n";

  /** Original content without standardized line breaks. */
  String _original;

  /** Separation of all lines for the string. */
  List<String> _lines;

  /**
		 * Constructs a new MultilineString.
		 */
  MultilineString(String string) : super() {
    initMultiString(string);
  }

  void initMultiString(String string) {
    _original = string;
    _lines = string.split(WIN_BREAK).join(NEWLINE_CHAR).split(MAC_BREAK).join(NEWLINE_CHAR).split(NEWLINE_CHAR);
  }

  /**
		 * Returns the original used string (without line break standarisation).
		 *
		 * @return the original used string
		 */
  String get originalString {
    return _original;
  }

  /**
		 * Returns a specific line within the <code>MultilineString</code>.
		 *
		 * <p>It will return <code>undefined</code> if the line does not exist.</p>
		 *
		 * <p>The line does not contain the line break.</p>
		 *
		 * <p>The counting of lines startes with <code>0</code>.</p>
		 *
		 * @param line number of the line to get the content of
		 * @return content of the line
		 */
  String getLine(int line) {
    return _lines[line];
  }

  /**
		 * Returns the content as array that contains each line.
		 *
		 * @return content split into lines
		 */
  List<String> get lines {
    return new List.from(_lines);
  }

  /**
		 * Returns the amount of lines in the content.
		 *
		 * @return amount of lines within the content
		 */
  int get numLines {
    return _lines.length;
  }
}
