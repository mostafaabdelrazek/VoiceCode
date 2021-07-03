class Language {
  Language(this.name,this.imagepath,this.extension , this.welcomeMessage);
  final String name ;
  final String imagepath;
  final String extension;
  final String welcomeMessage;
}

Language python = new Language(
    'Python', 'assets/pyicon.png', 'py' ,
    'print("Hello World!")\n'
);
Language cpp = new Language(
    'C++', 'assets/javaicon.png', 'cpp' ,
  '#include <iostream>\nusing namespace std;\n\n int main() {\n\tcount<< "Hello World!";\n\treturn 0;\n}'
);
Language php = new Language(
    'PHP', 'assets/phpicon.png', 'php' ,
    '<?php\necho "Hello World";\n'
);
Language c = new Language(
    'C', 'assets/cicon.png', 'c' ,
  '#include <stdio.h>\nint main(void) {\n\tprintf("Hello World!");\n\t\nreturn 0;\n}'
);