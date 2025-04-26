#include <cstdlib>
#include <iostream>

#include "absl/flags/flag.h"
#include "absl/flags/parse.h"
#include "absl/flags/usage.h"
#include "absl/log/absl_log.h"
#include "absl/log/initialize.h"
#include "absl/status/status.h"

ABSL_FLAG(bool, say_hello_twice, false, "Say hello world twice");

namespace {{template.project_name}} {
namespace {

absl::Status RealMain() {
  ABSL_LOG(INFO) << "Starting hello world program";

  std::cout << "Hello, World!\n";
  bool say_hello_twice = absl::GetFlag(FLAGS_say_hello_twice);
  if (say_hello_twice) {
    std::cout << "Hello, World!\n";
  }

  return absl::OkStatus();
}

}  // namespace
}  // namespace {{template.project_name}}

static constexpr char kUsage[] = "Print hello world and exit.";

int main(int argc, char** argv) {
  absl::InitializeLog();
  absl::SetProgramUsageMessage(kUsage);
  absl::ParseCommandLine(argc, argv);

  auto status = {{template.project_name}}::RealMain();
  if (!status.ok()) {
    ABSL_LOG(ERROR) << status;
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
