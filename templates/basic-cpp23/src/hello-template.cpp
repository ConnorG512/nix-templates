#include "hello-template.h"

#include <print>

auto Printer::printHello() -> void
{
  std::println("Hello template!");
}
