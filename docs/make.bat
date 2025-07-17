@ECHO OFF

REM Command file for Sphinx documentation

set SPHINXBUILD=sphinx-build
set BUILDDIR=_build

%SPHINXBUILD% -b html . %BUILDDIR%/html