#!/bin/sh
# Copyright 2019 gRPC authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

cd "$(dirname "$0")/../../.."

#
# Prevent the use of synchronization and threading constructs from std:: since
# the code should be using grpc_core::Mutex, grpc::internal::Mutex,
# grpc_core::Thread, etc.
#

egrep -Irn \
    'std::(mutex|condition_variable|lock_guard|unique_lock|thread)' \
    include/grpc include/grpcpp src/core src/cpp | \
    egrep -v include/grpcpp/impl/codegen/sync.h | \
    diff - /dev/null

