# lite-xl-WebSearch
Lite-xl plugin to perform Web search directly from The lite-xl editor

This plugin is made to perform a web search using your default browser
directly from your editor.


Default Behaviour is if you have a text selected it will take that
text as default input else it will open input with empty field.

default keybind is :

```keymap.add { ["ctrl+shift+b"] = "WebSearch:search-on-web" }```
Currently it supports 4 Search Engines: Google,Yahoo,Bing,DuckDuckGo
If your Search Engine of Choice is not listed, Feel Free to open an issue.
The default search engine is Google but you can change it by defining your Search Engine of choice
as 
```config.plugins.search="your_search_engine"```

Demo:

https://user-images.githubusercontent.com/61783895/180267133-b7813f91-7f80-42a7-91fd-69faf9b88062.mp4


