![image](https://github.com/lambdaclass/homebrew-cairo-lang/assets/53660242/04463074-fe48-460e-ae39-df14a56a59c2)
# Cairo support for `homebrew`

This repository is meant to support the [cairo](https://www.cairo-lang.org/) programming language for `homebrew` in MacOS.

### Installation
1. Add the homebrew tap to your device
```
brew tap lambdaclass/homebrew-cairo-lang
```
2. Install the desired package

    *(Make sure to add the **@** symbol to specify the version!)*
```
brew install lambdaclass/homebrew-cairo-lang/cairo-lang@2.2.0
```


#### NOTE:
If you encounter with an error that says `"rustup command not found, please run rustup-init to proceed..."`, this means that the `rustup` command was not found, meaning that you need to run `rustup-init` to install it, this cannot be done automatically since `homebrew` runs in a sandbox and thus prohibiting writing outside of it. Once done, you can then proceed with the installation normally.
