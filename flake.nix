{
  description = "Templates list Flake";
  
  outputs = { self, ... }: 
    templates = {
      basic-cpp23 = {
        path = ./basic-cpp23;
        description = "A very basic C++23 template with release and debug builds.";
      };
    };
    
    defaultTemplate = self.templates.basic-cpp23;
}
