bool urlIsvalid(String url) {
  return Uri.tryParse(url)?.hasAbsolutePath ?? false;
}
