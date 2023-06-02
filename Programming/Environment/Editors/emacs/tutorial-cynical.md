# A Modern (read: Cynical) Emacs Tutorial

## Preliminary Opinions

Just so you know where my biases are:
  - The "Macintosh Human Interface Guidelines" won.
    Every modern desktop app uses them (or gestures at them).
    No one cares that the some unix terminals got there first.
    And for the record, vi predates emacs, so emacs wouldn't have set the standard anyway, if being first was what counted.
  - Terminal input is fundamentally broken.
    Try reading the docs for [vty](https://hackage.haskell.org/package/vty-5.38/docs/Graphics-Vty-Input.html).
    Lots of key combinations accessible on standard ANSI and ISO keyboards simply cannot be detected by applications correctly.
  - Vi design philosophy is largely sound.
    However, being a stickler against (e.g.) PgDn/PgUp is foolishly holding onto a past where keyboards didn't have arrow keys.
    Also, it doesn't hold up do it's design philosophy perfectly.
      I've set my vim up so that a quick-fire `jf` sequence is equivalent to `<Esc>`, and keeps my fingers from constantly flying to a far corner of the keyboard.
      I've also set it up so that `;` is the command leader instead of `:`, so I don't have to engage the shift key so much.
  - I find between multiple cursors and language-agnostic algorithms (such as matching common delimiters or understanding case conventions) are enough to perform most tasks.
    Macros are sometimes nice, but if you find yourself running similar macros again and again, you probably want a command.

## Notation

Emacs commands often involve holding either control or alt while pressing another key.
The now-standard notation for this is `ctrl+KEY` and `alt+KEY`, and that is what we will use here.
Keys that aren't standard alphanumerics will be named in angle brackets (e.g. `ctrl+<down>`).

The emacs manuals write these as `C-KEY` and `M-KEY`.
While `C-` makes sense, `M-` is a holdover from when the Stanford AI Lab (SAIL) made keyboards.
Standard keyboards these days do not have a "meta" key; they have and alt key.
Apple has to be a special snowflake, and call these keys "command" and "option", respectively.

A sequence of (possibly modified) key will be notated by placing spaces between the strokes.
That is, a space indicated all keys should be released before the next stroke (modifiers can stay down, unless the next stroke doesn't call for it).

## Important Info

To quit, type `ctrl+x ctrl+c`.

In the emacs tutorial, oof of which this is based, `ctrl+x k <enter>` will end the tutorial.
I don't like having my tutorial in the application itself; one gets in the way of the other.

The `>` character at the left margin indicates instructions to try a command.
This uses markdown quotation syntax, rather than whatever weird one-off syntax emacs is using here.

## Navigating

The first thing that you need to know is how to move around from place to place in the text.
This already works a lot like you would expect from any GUI or modern TUI interface:

  - The scroll wheel moves the view, and keeps the cursor on screen.
  - The `<up>` and `<down>` arrow keys move up and down by one line.
  - The `<left>` and `<right>` arrow keys move one character left and right,
    looping to the end/start of the previous/next line at the end of a line
  - The `ctrl+<left>` and `ctrl+<right>` keys move left/right by one word.
  - `<Home>` and `<End>` move to the start/end of a line.
  - `<PgUp>` and `<PgDn>` move up and down one page, respectively.
  - `ctrl+<Home>` and `ctrl+<End>` move to the start/end of the whole text.

Emacs has a nice addition to this:
  - The `ctrl+<up>` and `ctrl+<down>` keys move up/down by one paragraph,
    which are delimited by blank lines.

There are a whole bunch of other special emacs key combos you can use to move around.
For example, `C-a` will move to the "Aeginning of the line", and `C-w` will "move forward one Word"... or is "delete one Word behind"…?
Uh… see how mnemonic it is? Yeah!
Perhaps you'll decide to keep them around, and — like one expert — accidentally close a browser window instead of deleting a word.
Perhaps you'll choose to use some more vim-like navigation keybindings that save more time.
Who cares right now? The important thing is you didn't actually have to learn anything new to get started!
Optimization can — and will — come later.

Most commands accept a numeric argument, but I've found it to be un-useful.
If you wanna try it, use `ctrl+u`, then type your number, then your command.
E.g. `ctrl+u 8 <right>` moves the cursor eight characters to the right.
Unless you're doing the command a subitizable number of times, this comes up pretty rarely, and the extra `<ctrl+u>` keystroke I think is kinda unergonomic cmopared to vim, where you can just type the number immediately.
TODO If I can find a way to put relative line numbers along the side, then number+up/down might be nice, but the jury is out since it's so easy to move by paragraph, and paragraphs are usually carriers of semantic value.

## If Emacs Stops Responding

If Emacs stops responding to your commands, you can stop it safely by typing `ctrl+g`.
You can use `ctrl+g` to stop a command which is taking too long to execute.

You can also use `ctrl+g` to discard a numeric argument or the beginning of a command that you do not want to finish.

> Type `ctrl+u 100` to make a numeric argument of 100, then type `ctrl+g`.
> Now type `<right>`.
> It should move just one character, because you canceled the argument with `ctrl+g`.

If you have typed an `<Esc>` by mistake, you can get rid of it with a `ctrl+g`.
Of course, I'm not yet sure _how_ you would type `<Esc>` by accident, seeing as it's not near many other keys except backtick, which isn't very commonly used outside LaTeX.
TODO More importantly, I'm not sure under what circumstances `<Esc>` actually does anything bad; it seems to do the same thing as `ctrl+g` so far.

## Disabled Commands

Some Emacs commands are "disabled" so that beginning users cannot use them by accident.

If you type one of the disabled commands, Emacs displays a message saying what the command was,
  and asking you whether you want to go ahead and execute the command.

Normally, if you do not want to execute the disabled command, answer the question with "n".
If you really want to try the command, then read the message that pops up; there are four other options.

> Type `ctrl+x ctrl+l` (which is a disabled command), then type `n` to answer the question in the negative.



================

Major modes are called major because there are also minor modes.
The missile knows where it is at all times. It knows this because it knows where it isn't.

================

The Emacs manual contains a Glossary of Emacs terms.
Emacs also has search-and-replace functionality, so I'm not sure what the excuse is to avoid bringing its documentation into line with modern terms.
