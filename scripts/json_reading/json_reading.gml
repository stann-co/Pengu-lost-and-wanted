/// @function file_read_all_text(filename)
/// @description Reads entire content of a given file as a string, or returns undefined if the file doesn't exist.
/// @param {string} filename		The path of the file to read the content of.
function file_read_all_text(_filename) {
	if (!file_exists(_filename)) {
		return undefined;
	}
	
	var buffer_ = buffer_load(_filename);
	var result_ = buffer_read(buffer_, buffer_string);
	buffer_delete(buffer_);
	return result_;
}

/// @function file_write_all_text(filename,content)
/// @description Creates or overwrites a given file with the given string content.
/// @param {string} filename		The path of the file to create/overwrite.
/// @param {string} content			The content to create/overwrite the file with.
function file_write_all_text(_filename, _content) {
	var buffer_ = buffer_create(string_length(_content), buffer_grow, 1);
	buffer_write(buffer_, buffer_string, _content);
	buffer_save(buffer_, _filename);
	buffer_delete(buffer_);
}

/// @function json_load(filename)
/// @description Loads a given JSON file into a GML value (struct/array/string/real).
/// @param {string} filename		The path of the JSON file to load.
function json_load(_filename) {
	var json_content_ = file_read_all_text(_filename);
	if (is_undefined(json_content_))
		return undefined;
	
	try {
		return json_parse(json_content_);
	} catch (_) {
		// if the file content isn't a valid JSON, prevent crash and return undefined instead
		return undefined;
	}
}

/// @function json_save(filename,value)
/// @description Saves a given GML value (struct/array/string/real) into a JSON file.
/// @param {string} filename		The path of the JSON file to save.
/// @param {any} value				The value to save as a JSON file.
function json_save(_filename, _value) {
	var json_content_ = json_stringify(_value);
	file_write_all_text(_filename, json_content_);
}

