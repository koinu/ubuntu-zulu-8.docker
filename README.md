# Zulu 8 in Ubuntu LTS

## About

This container is based on Ubuntu LTS and includes [Azul Systems' Zulu](https://www.azul.com/products/zulu/) distribution of OpenJDK. Zulu is fully compatibility-certified, but unlike Oracle's JRE/JDK binaries, is free of any problematic license terms. It is the Java you want to use if your needs are not met by your distribution's OpenJDK package.

## Differences from Azul Systems' container images

### Uses `C.UTF-8` Locale

The `LANG` environment variable is set to `C.UTF-8`, which ensures the use of UTF-8 encoding _without_ otherwise deviating from POSIX behavior.

### Configures unlimited cryptography policy

No more connection failures due to third party servers forcing the use of strong key lengths.

### Includes appropriate SecureRandom configuration

SecureRandom is configured to use `/dev/urandom` as the source for entropy. Additionally, `NativePRNGNonBlocking` is configured as the "Strong" algorithm/provider, which prevents `SecureRandom.getInstanceStrong()` from returning something that blocks.

See [Myths about /dev/urandom](http://www.2uo.de/myths-about-urandom/) for a breakdown of why this does _not_ weaken security. The alternative, leaving SecureRandom's configuration at defaults, is very, _very_ unsafe as far as application availability and performance are concerned.

### Fewer layers

At the time of this writing, `azul/zulu-openjdk` does not clean up temporary files (including the apt cache) and has multiple `RUN` commands in series, which results in unnecessary layers.
