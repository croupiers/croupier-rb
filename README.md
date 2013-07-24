# Croupier

Croupier generates random samples of numbers with specific probability distributions.

[![Gem Version](https://badge.fury.io/rb/croupier.png)](http://badge.fury.io/rb/croupier)
[![Build Status](https://secure.travis-ci.org/xuanxu/croupier.png?branch=master)](http://travis-ci.org/xuanxu/croupier)

## Install

You need to have Ruby and Rubygems installed in your system. Then install croupier with:

    $ gem install croupier

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

    $ croupier uniform 500                  # => 500 numbers with uniform distribution in [0,1] (default interval)
    $ croupier uniform 125 -min 7 -max 15   # => 125 numbers with uniform distribution in [7,15]
    $ croupier exponential 1000 -lambda 1.3 # => 1000 numbers following an exponential distribution with rate 1.3

### Available distributions and options

Current version implements the following distributions:

* Bernoulli
* Binomial
* Cauchy
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

And then use the the distribution you want to generate the sample. You can get just one number (using ```.generate_number```) or an array of any given size (using ```.generate_sample(N)```)

    dist = Croupier::Distributions::Exponential.new(:lambda => 1.7)
    dist.generate_sample(100) #=> returns an array of 100 random numbers following an exponential with rate 1.7
    dist.generate_number #=> returns one random number following an exponential with rate 1.7

It's posible to instantiate each Distribution class directly:

    dist = Croupier::Distributions::Exponential.new(:lambda => 1.7)

or calling Distributions methods:

    dist = Croupier::Distributions.exponential :lambda => 1.7

To get a list of all available distributions/methods in Distributions module call ```list```

    Croupier::Distributions.list

Since 1.6.0, distributions have a ```to_enum``` method that return an (infinity) enumerator, so you
can use any Enumerable method on it:

    dist = Croupier::Distributions.exponential(:lambda => 17).to_enum
    dist.each_slice(2).take(3)
    => [[0.7455570432863594, 1.6543154039789472], [4.261950709816685, 0.2860058032480469], [1.4761279576207826, 0.6433699882662834]]

## How to generate a new distribution.

There are several ways. The easiest one is to override ```generate_number``` or ```generate_sample``` (one is enough).

Nonetheless there is another cool way to implement a distribution: implementing ```inv_cdf```:

```ìnv_cdf``` receives a parameter ```n``` that is a sample of a uniform distribution. It should return the inverse of the cdf applied to ```n```.

## License

Croupier is released under the MIT license.

## Credits

Developed by Juanjo Bazán [`@xuanxu`](http://twitter.com/xuanxu) & Sergio Arbeo [`@serabe`](http://twitter.com/serabe)

Follow news and releases on twitter: [`@CroupierGem`](http://twitter.com/CroupierGem)
