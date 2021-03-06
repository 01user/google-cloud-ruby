import synthtool as s
import synthtool.gcp as gcp
import logging
import re

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

# Temporary until we get Ruby-specific tools into synthtool
def merge_gemspec(src, dest, path):
    regex = re.compile(r'^\s+gem.version\s*=\s*"[\d\.]+"$', flags=re.MULTILINE)
    match = regex.search(dest)
    if match:
        src = regex.sub(match.group(0), src, count=1)
    regex = re.compile(r'^\s+gem.homepage\s*=\s*"[^"]+"$', flags=re.MULTILINE)
    match = regex.search(dest)
    if match:
        src = regex.sub(match.group(0), src, count=1)
    return src

v1_library = gapic.ruby_library(
    'kms', 'v1', artman_output_name='google-cloud-ruby/google-cloud-kms',
    config_path='artman_cloudkms.yaml'
)
s.copy(v1_library / 'lib')
s.copy(v1_library / 'test')
s.copy(v1_library / 'Rakefile')
s.copy(v1_library / 'README.md')
s.copy(v1_library / 'LICENSE')
s.copy(v1_library / '.gitignore')
s.copy(v1_library / '.rubocop.yml')
s.copy(v1_library / '.yardopts')
s.copy(v1_library / 'google-cloud-kms.gemspec', merge=merge_gemspec)

# PERMANENT: API name for cloudkms
s.replace(
    [
      'README.md',
      'lib/google/cloud/kms.rb',
      'lib/google/cloud/kms/v1.rb',
      'lib/google/cloud/kms/v1/doc/overview.rb'
    ],
    '/kms\\.googleapis\\.com', '/cloudkms.googleapis.com')

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('([^#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\\\\\\\{\\2}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/kms/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')
