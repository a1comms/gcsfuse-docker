# The MIT License (MIT)
# Copyright (c) 2017 lev.v.kuznetsov@gmail.com
# Copyright (c) 2019 sam.melrose@a1comms.com
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

FROM ubuntu:22.04

RUN apt-get update && apt-get dist-upgrade -y

ADD gcsfuse_0.41.8_amd64.deb /root/gcsfuse_0.41.8_amd64.deb

RUN apt-get install -y --no-install-recommends ca-certificates wget gnupg fuse && \
    dpkg -i /root/gcsfuse_0.41.8_amd64.deb

RUN rm -f /root/gcsfuse_0.41.8_amd64.deb

RUN apt-get clean && rm -rf /var/lib/apt/lists
