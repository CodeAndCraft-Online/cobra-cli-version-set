# Cobra CLI Build Test

A Go CLI application built with Cobra that demonstrates building Windows binaries with proper executable properties.

## Features

- Built with [Cobra CLI](https://github.com/spf13/cobra-cli)
- Windows executable includes proper version information and properties
- Cross-platform build support
- Automated build process via Makefile

## Windows Binary Properties

The Windows executable includes the following properties:

- **Product Name**: Cobra CLI Build Test
- **Product Version**: 1.0.0.0
- **File Description**: Cobra CLI Application
- **Company Name**: Your Company Name
- **Copyright**: Copyright © 2025 Your Company Name

## Building

### Prerequisites

- Go 1.19 or later
- Make (optional, for using the Makefile)

### Install Dependencies

First, install the required tools:

```bash
# Install Cobra CLI
go install github.com/spf13/cobra-cli@latest

# Install goversioninfo for Windows properties
go install github.com/josephspurrier/goversioninfo/cmd/goversioninfo@latest
```

### Build Windows Binary

Use the Makefile to build:

```bash
# Build Windows executable with properties (amd64 only)
make build-windows

# Or build manually (single architecture, no platform-specific files)
goversioninfo -64=true -o resource_windows_amd64.syso versioninfo.json
set GOOS=windows&& set GOARCH=amd64&& go build -ldflags="-s -w" -o cobra-cli-windows-amd64.exe .
```

### Verify Properties

After building, verify the Windows properties are set correctly:

```bash
# Using Makefile
make show-properties

# Or manually with PowerShell
powershell -Command "Get-Item 'cobra-cli-windows-amd64.exe' | Select-Object VersionInfo | Format-List"
```

Expected output should show:
```
VersionInfo : File:             ...cobra-cli-build-test-windows-amd64.exe
              InternalName:     cobra-cli-build-test
              OriginalFilename: cobra-cli-build-test.exe
              FileVersion:      1.0.0.0
              FileDescription:  Cobra CLI Application
              Product:          Cobra CLI Build Test
              ProductVersion:   1.0.0.0
              Language:         English (United States)
```

## Adding an Icon

To add an icon to the Windows executable:

1. **Add the .ico file**: Place your icon file (in .ico format) in the project root or a desired location
2. **Update IconPath**: In `versioninfo.json`, set the `"IconPath"` field to point to your .ico file:

   ```json
   {
     ...
     "IconPath": "your-icon.ico",
     ...
   }
   ```

3. **Rebuild**: Run `make build-windows` or the manual build commands

No further actions are needed - the .ico file will automatically be embedded into the Windows executable and displayed in Windows Explorer and the taskbar.

### Converting Images to ICO Format

If you have a PNG, SVG, or other image format, you can convert it to .ico using tools like `icon-gen`:

```bash
# Install icon-gen globally
npm install -g icon-gen

# Convert PNG to ICO
icon-gen -i your-image.png -o . --ico --ico-name your-icon
```

## How It Works

1. **versioninfo.json**: Contains the Windows version information structure
2. **goversioninfo**: Compiles the JSON into platform-specific .syso resource files
3. **Go linker**: Automatically includes the .syso files when linking the executable

The `.syso` files are platform-specific resource files that contain the version information, icons, and other metadata Windows uses for executable properties.
