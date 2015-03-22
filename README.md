Cantus Firmus Generator
===============

This is an app that allows you to generate a [Cantus Firmus](http://www.openmusictheory.com/cantusFirmus.html) using real world examples to guide it's creation.

It works by generating a phrase and adding one note at a time. Before it can add a note, the program checks for "hard rules", with the rules and scale classes. Next it checks for compliance with "soft rules" from given examples, with the note_picker and evaluator classes.

You can read more about my thought process on [my blog](http://www.alexbeeken.com).

## Installation

You can see the latest working version on [this heroku link](http://cantusfirmusgenerator.herokuapp.com).

1. You can also clone this repository with `git clone http://github.com/alexbeeken/cantusfirmus2`.

2. Navigate to it's directory on your local machine and run `bundle`.

3. Run `ruby app.rb`.

4. Open a browser and go to `localhost:4567`.

## Testing

Run `rspec` in the home directory.

## Contributing

1. Fork it!

2. Follow installation instructions to see it running.

3. Make changes.

4. Commit.

5. Submit a pull request.

## License

MIT
