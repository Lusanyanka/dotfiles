# Dynamic Colors

Dynamic terminal colors in the shell script work by sending terminal OSC sequences.  The trick is that the terminal emulator needs to support the OSC sequences for the colours to change.  The OSC sequences used are definitely supported by rxvt-unicode.

## Designing Dynamic Schemes
`load_scheme.sh` tries to implement intelligent defaults for the values in a color scheme, if they're left undefined.  At minimum, however, a color scheme must define colors 0-7.  The scheme files themselves are a shell script, which gets sourced by `load_scheme.sh` to define the color variables.  Color scheme templates can be found in the `template` directory.

## OSC Sequences
The OSC sequences take the following form:
```
\033]<OSC_number>;<args>\007
```

## OSC Numbers
Of the various OSC numbers defined, the following are relevant to dynamic colors in the terminal
| Number | OSC        | Argument |
| ------ | ---------- | -------- |
| 4      | color      | semi-color separated list of color-numbers and values |
| 10     | foreground | single hex-value to define the foreground |
| 11     | background | single hex-value to define the background |
| 12     | cursor     | single hex-value to define the cursor color |
| 708    | border     | single hex-value for the border of the window, which is used if there is any area where characters are _not_ drawn, i.e. in a tiling window manager |

Example sequence to set black (color 0) to `#coffee`: `\033]4;0;#coffee\007`
Example sequence to set foreground to `#coffee`: `\033]10;#coffee\007`
