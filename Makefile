# Makefile for building Windows binary with proper properties

.PHONY: build clean build-windows test

# Build for current platform
build:
	go build -ldflags="-s -w" -o cobra-cli-linux .

# Build Windows executable (amd64) with version info
build-windows:
	goversioninfo -64=true -o resource_windows_amd64.syso versioninfo.json
	set GOOS=windows&& set GOARCH=amd64&& go build -ldflags="-s -w" -o cobra-cli-windows.exe .

# Build all targets
all: build-windows

# Clean build artifacts
clean:
	del cobra-cli-windows.exe 2>nul || echo "No windows exe to clean"
	del resource_windows_amd64.syso 2>nul || echo "No syso files to clean"
	del cobra-cli-linux 2>nul || echo "No linux binary to clean"

# Test the executable
test:
	.\cobra-cli-windows.exe --help

# Show Windows properties
show-properties:
	powershell -Command "Get-Item 'cobra-cli-windows.exe' | Select-Object VersionInfo | Format-List"
