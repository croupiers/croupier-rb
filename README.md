# Croupier

Croupier generates random samples of numbers with specific probability distributions.

[![Gem Version](https://badge.fury.io/rb/croupier.png)](http://badge.fury.io/rb/croupier)
[![Build Status](https://secure.travis-ci.org/croupiers/croupier-rb.png?branch=2.0)](http://travis-ci.org/croupiers/croupier-rb)

## Install

You need to have Ruby and Rubygems installed in your system. Then install croupier with:

    $ gem install croupier --pre

## Getting Started

Once you have croupier installed in your machine, you can run the gem using the `croupier` executable:

    $ croupier

The common case for invoking Croupier is:

    $ croupier <distribution> <sample_size> [<options>]

where:

* ```<distribution>``` is the name of the desired distribution of the random sample.
* ```<sample_size>``` is an integer representing the size of the desired sample.
* ```<options>``` are any extra parameters needed by the actual distribution. (If not options are provided croupier will use the default parameters for the distribution being called).

### Examples

    $ croupier uniform 500                  # => 500 numbers with uniform distribution in [0,1) (default interval)
    $ croupier uniform 125 --included 15 --excluded 7   # => 125 numbers with uniform distribution in (7,15]
    $ croupier exponential 1000 -lambda 1.3 # => 1000 numbers following an exponential distribution with rate 1.3

### Available distributions and options

Current version implements the following distributions:

* Bernoulli
* Binomial
* Cauchy
* Credit Card
* Degenerate
* Exponential
* Gamma
* Geometric
* Negative binomial
* Normal
* Poisson
* Triangular
* Uniform

To get a list of all the available distributions use the ```--help``` (or ```-h```) option with croupier:

    $ croupier --help

To get a list of all the available options for a given distribution use ```--help``` (or ```-h```) option with any available distribution:

    $ croupier exponential --help  # => will list all the options for the exponential distribution

## Using Croupier from a ruby application

If you want to generate random numbers from your ruby code you can use the Distribution class that you need.
All the available distributions are located in the ```Croupier::Distributions``` module and are represented by a class inheriting from the ```Croupier::Distribution``` class.
First of all require the croupier library:

    require 'croupier'

And then use the the distribution you want to generate the sample. Since version 2.0, all ```Croupier::Distribution```s
are ```Enumerable```s, and the ```.generate_number``` and ```.generate_sample(n)``` methods are now deprecated.
 ```first``` and ```take(n)``` can be used instead.

    dist = Croupier::Distributions.exponential(lambda: 1.7)
    dist.take(100) #=> returns an array of 100 random numbers following an exponential with rate 1.7
    dist.first #=> returns one random number following an exponential with rate 1.7

Though it's posible to instantiate each Distribution class directly:

    dist = Croupier::Distributions::Exponential.new(lambda: 1.7)

calling methods on ```Croupier::Distributions``` (note the final s) module is recommended:

    dist = Croupier::Distributions.exponential lambda: 1.7

To get a list of all available distributions/methods in ```Distributions``` module call ```list```

    Croupier::Distributions.list

Distributions' Enumerable behaviour comes from an infinite ```Enumerator::Lazy```. Take this into account
when calling ```Enumerable``` methods.

    dist = Croupier::Distributions.exponential(lambda: 17)
    dist.each_slice(2).take(3)
    => [[0.7455570432863594, 1.6543154039789472], [4.261950709816685, 0.2860058032480469], [1.4761279576207826, 0.6433699882662834]]

## How to generate a new distribution.

 TO BE COMPLETED WHEN API IS FINISHED.

## License

Croupier is released under the MIT license.

## Credits

Developed by Juanjo Bazán [`@xuanxu`](http://twitter.com/xuanxu) & Sergio Arbeo [`@serabe`](http://twitter.com/serabe)

Follow news and releases on twitter: [`@CroupierGem`](http://twitter.com/CroupierGem)
