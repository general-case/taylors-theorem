// Set document properties.
#set page(paper: "us-letter")
#set text(size: 12pt, font: "New Computer Modern", weight: 500) // Larger font.
#set text(hyphenate: false) // Prevent all automatic line breaks.
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)", supplement: [equation]) // Default reference is "equation".

#show "p-series": it => box(it) // Prohibit line breaks in this term.
#show math.equation.where(block: false): box // Prohibit line breaks for inline math.

// #show math.equation.where(block: true): set align(left)

// Notes
/*
There are 3 core modes: markup (content surrounded by [ ]), code (content preceded by #), and math (content surrounded by $ $).
Markup is the default mode but you can explicitly enter markup mode by surrounding the content with square brackets.

If a math expression inside the $ $ delimiters is surrounded by spaces then the expression is typeset in display (block) mode.
Otherwise, the expression is typeset in line mode.

In code mode, curly braces are used to define a code block.

Code that needs to access contextual data, such as heading numbers, page numbers, equation numbers, etc, must run inside a context aware
expression or code block introduced by the #context keyword. This requirement appears to be due to some kind of implementation detail.

The @preview namespace on the import statement refers to the namespace for community contributed packages.

Labels are enclosed in angle brackets, e.g. <sec:my_section>, and referenced using the @ notation, e.g. @sec:my_section.

The show statement works like a CSS rule with a selector followed by styling.
The show keyword followed by a selector and style are called a show rule.
A show rule with a blank selector applies the styling every element in the document from the point of invocation.
When a function is used as a show rule style, it is applied to each matching element, in a manner analogous to the visitor pattern.

The let statement allows you to introduce a variable and assign a value to it or define a function.

Content may be placed in square brackets following a function call. This construct is called a trailing content block.

The argument spreading operator .. converts an array to a sequence of positional arguments.
Functions like table and grid take data as a sequence of positional arguments rather than an array.

*/

// Imports
#import "util.typ":*
#import "@preview/theorion:0.3.3":*
#import emoji:face

// Apply the show-theorion function to all elements in the document.
#show : show-theorion

// Title
#v(1in)
#let title = [A friendly guide to Taylor's theorem]
#align(center, text(18pt)[#title])
#v(0.5in)

// My ORCID link
#let orcid = link("https://orcid.org/0009-0004-8349-6212")[
    #box(image("ORCID-iD_icon_32x32.png", width: 10pt))
]

// Author
#let author = [David Elliman] + [#orcid]
#align(center, text(14pt)[#author])

// Publication date
#align(center, text(14pt)[June 2026])
#v(0.5in)

// #align(horizon, heading(numbering: none)[Abstract])

// Style the abstract heading.
#show <sec:abstract>: set heading(numbering: none)
#show <sec:abstract>: set align(center)

= Abstract <sec:abstract>

Work in progress!\
Taylor's theorem is one of the most important in all of mathematics and truly understanding it means that you have achieved
a significant level of _mathematical maturity_, but it can be challenging to find an explanation of the theorem in plain language.
Taylor's theorem has enormous practical value. In fact, it is the theorem that provides the underlying algorithm that your
calculator uses to almost instantly compute the values of functions such as sine, cosine, and the exponential function ($e^x$).
In this paper, I'll present a somewhat informal account of what Taylor's theorem actually is, and why it is useful for calculating the 
values of functions. On our journey to understanding Taylor's theorem we'll take a look a prerequisite objects such as
polynomials, power series, Taylor polynomials, and the Taylor series.
We'll conclude with a look at how Taylor's theorem is used to define the sine function from scratch, mathematically rather than
geometrically.


#pagebreak()

// Start page numbering on page 2.
#set page(numbering: "1")

// Contents if I need it later.
// #outline()


= Introduction <sec:introduction>

What will you need to understand this paper?
Well, you'll need to be familiar with the real numbers, have a good grasp of what a function is
and know a couple of different types of functions, like real-valued functions over the reals (aka real functions) and functions over the natural numbers.
You'll also need a basic understanding of calculus, at least to the point where you know what a derivative is and what an integral is.
It would be helpful if you've solved a quadratic equation or two.
Also, you should know a little bit about sets, subsets, and power sets, at least what they are.
First-year college mathematics or highschool AP calculus should be more than enough preparation.

When writing an _accessible_ paper on a topic it's hard to know how far back to go explaining the basic principles.
Too much of this can result in endless backtracking where the main topic of the paper becomes lost in a sea of basic ideas, but too little
risks not setting the stage sufficiently so that the reader can understand the core ideas with ease.

In this paper, I'll try to strike a balance by briefly laying out some basic mathematical ideas that can be covered in just a page or two,
without presenting an entire treatise on predicate logic.

Also, it's difficult to perfectly sequence concepts pedagogically, so you may encounter a term that has not yet been fully discussed.
For that reason, you may want to read each section twice so that all the concepts are fully defined and fresh on your second reading.
I've tried to keep each section as self-contained as possible.


= Mathematical preliminaries

Let's begin with a lightning tour of some essential mathematical concepts.
In this section, there'll be a lot of statements like _there are only two of blah_ or _there is only one something or other_.
You can think of statements like these as _intellectual handholds_ that you can literally, no metaphorically
#text(emoji.face.smile.slight, 8pt),
grab on to as you scale the heights of the mathematical edifice.
They express ideas that you can _take to the bank_; that you can always count on.

Also, you should know that mathematics is mostly written in an informal but highly stylized language,
but for each piece of informal language there is a formal counterpart that sometimes looks a bit like computer code
(especially the way I write it).
I'll introduce the formal notation first because it is more precise and can actually be easier to understand.

By the way, we should talk about that word "formal", and another word "rigor". These come up in mathematical texts all the time.
When I was learning math as a teenager (a long time ago), I imagined that the phrase "formal mathematics" meant that you were supposed to 
wear a tux, or at least a suit and tie, and scowl at people over a pair of reading glasses for not being formal enough.
Of course that's not what _formal_ means in mathematics at all. It simply means that the mathematics is expressed in a language
that has a _particular form_, whether that is the standard stylized language of most textbooks on the subject or the language of formal
logic.
As for rigor, I used to think that this meant that doing math was _arduous_ and involved a lot of _hard work_.
Nope! Wrong again! Rigor simply means that no step is missed out or _hand-waved_ over in the process of deriving a formula.
Now it's fair to say that some authors do leave out steps
that they consider _elementary_ or _trivial_, but by and large in a _rigorous mathematical proof_ all of the steps of the argument
will be stated explicitly.


== Objects

Mathematics is all about objects: natural numbers, real numbers, functions, vectors, matrices, perfectoid spaces, and on and on.
All mathematical objects have to be introduced into your paper via a official _declaration_ at some point
before you start making statements about them.
That said, for many ordinary objects, like say the real numbers, the declaration is understood to be elsewhere, outside your paper.
For example, if you write a paper in which you prove something about the real numbers, you don't have to declare the set of
real numbers inside your paper. They are assumed to be _predefined_ somewhere else.
However, if you introduce some new object of your own invention, then you do have to declare it within your paper.
Let's say you want to introduce some special integer, call it $n$, that you want to talk about in your paper.
The notation to do that is like this:

$ n:ZZ; $

If you want to introduce a real function, say $f$, here's how you would do that:

$ f:RR -> RR; $

The arrow is the function constructor that indicates a function is being declared.

Lastly, let's say you want to introduce some set of integers. Let's call it $S$. Here's how you would do that:

$ S:"type" ZZ; $

This one says $S$ is one element of the power set of the integers, and therefore $S$ is a _subset_ of the integers, which, by the way,
could be the entire set of integers or it could even be the empty set.

In each case, the symbol to the left of the colon is the name we're introducing, the _handle_ if you will, that references the object.
The symbol(s) to the right of the colon are the _type_ of the object being declared.
The whole declaration statement is terminated by a semicolon.

Now in most mathematical textbooks you won't see declarations written in such a formal, almost code like way.
Instead, the objects will be introduced using that stylized mathematical language that we talked about earlier.
For our three objects, the declarations would be written something like: "let $n$ be an integer", "let $f$ be a real function",
and "let $S$ be a set of integers".

Incidentally, programmers are very used to this idea of declaring objects before using them.
Back in the day, programming languages required that you declare every single object before use, but these days some programming languages
figure out (_infer_) the declaration for you based on the context in which the object is used.
Here are our declarations as they might appear in the C programming language.

```c

// Let n be an integer.
int n;

// Approximate a real function.
float f(float x)
{
    return x*x;
}

// Approximate a set of integers.
// Note: this would need more to make it work like an actual mathematical set.
int S[] = {-3,-2,-1,0,1,2,3}

```

The declaration statement associates every object with a type, but why is that? Why do we need a type on every object?
Well, it's really an _apples to apples_ thing. The type is like a little _tag_, or a _label_, that stays with the object
throughout your paper.
Its purpose is to prevent you from comparing one object to a totally different kind of object.
In other words, the type is used to stop you from comparing _apples to oranges_.
In mathematics, mixing different kinds of objects inappropriately in a statement can lead to a _paradox_.
For example, you wouldn't want to say that a natural number is equal to a matrix, or that a real number is a member of a set of vectors.
Paradoxes are bad; they turn your conclusions into nonsense.
One famous paradox was discovered by Bertrand Russell in 1901.
It is known as _Russell's paradox_ and there's even a translation of it written in everyday language known as the _Barber Paradox_.

In programming languages too we use types on objects (well, except in Python),
and there's usually a type system built into the compiler that checks that every statement is correct from a types perspective.
In programming we don't get paradoxes; we get bugs.
In fact, arguably the second most important advance in computer science, after Turing's 1936 paper,
was the introduction of types into programming languages (starting with the typed lambda calculus).
A famous and very expensive bug due to a type mismatch occurred in NASA's Mars Climate Orbiter, which burned up in the Martian
atmosphere after the software calculated the wrong orbit trajectory.

Ok, so we have introduced the names of the objects we want to talk about, but where do these objects live exactly?
Well, some suggest that they might really exist in realm called the _Platonic Universe_, a place where perfect abstract forms exist.
I don't know if I'd go that far,
but the objects do of course exist in your imagination and the shared imaginations of several people studying the same topic in math.
Also, if you're modelling mathematical objects inside a computer program, they exist in the computer's memory.
In a sense, mathematical objects exist in the same way that talking lions exist in a fantasy novel.

Now here comes another one of those _intellectual handholds_.
There are #underline[only two kinds of basic mathematical objects], sets and functions.
The myriad of other mathematical objects are built out of just these two kinds of basic object.
This situation is kind of like if you ordered a box of toy construction blocks, say Lego, from Amazon.
The box arrives and the pictures on the outside show all of the things you can build, spaceships, planes, cars, and so on,
but when you open the box you find that there are only two kinds of brick inside. What? You are confused.
But as you start to play with the blocks, you find that you can indeed build all of those things from just the basic blocks in the set.
Cool! That's how mathematics works. You can build everything from sets and functions.

But if sets are collections of things what about the elements of a set?
Aren't they some kind of atomic object with no internal structure?
Well yes and no. Some accounts of mathematics include a third kind of basic object called a _urelement_ that is indeed an atomic
object with no internal structure. However, if you think about it, you could use either a function or a set as a urelement as long
as you commit to not talking about its internal structure, and that's exactly what we'll do here.
We can think of our simple set elements as being either sets or functions, but we're not going to say which and we're not going
to talk about their set or function properties.

== Statements

In everyday English, there are three kinds of sentences:

- Interrogative which ask a question
- Imperative which give an instruction or a command
- Declarative which simply assert something is true

That last one, the _declarative sentence_, has a parallel in mathematics called the _mathematical statement_.
In English, declarative sentences can be true or false. For example, I can say that "the sky is blue", but you can look up and perhaps
see that the sky is in fact grey. Similarly, a mathematical statement is either true or false. For example, $2+2=4$ is true but $2+2=5$ is false. And just like declarative sentences, it's up to you to decide whether a given mathematical statement is true or false.
In fact, mathematics is unconcerned with the truth or falsity of statements - it only cares about relationships between the statements.
The theorems, properties, and axioms of mathematics are all just mathematical statements.

It may surprise you to learn that there are only #underline[two kinds] of fundamental, _non-trivial_, mathematical statements.
There are equality statements, again like $2+2=4$ and $2+2=5$, and there are set membership statements, like $2 in NN$, which tells
you that the number 2 is a member of the set of natural numbers.
There are also a couple of _trivial_ fundamental statements, *true* and *false*.
These are useful in certain technical scenarios inside mathematical proofs, but we won't be using them in this paper.
They're labeled _trivial_ because they don't actually say anything about mathematical objects.

Now you may be wondering how can it be that all of mathematics rests on these four kinds of statement?
How can we possibly state all of the theorems, properties, and axioms of mathematics using just these four types of primitive statement?
Well, we're allowed to combine the primitive statements using _logical operators_ to form more complex statements.
These logical operators come from _propositional logic_ and are more or less identical to boolean operators, which if you've done
any computer programming you will very likely be familiar with.

There are #underline[just five] logical operators.
Their names and symbols are: And $and$, Or $or$, Not $not$, Implies $=>$, and if-and-only-if $<=>$ (aka iff and equivalence).
Now spoiler alert, these five operators can be reduced to just one called NAND, and this is often done in computer circuits for efficiency,
but in mathematics we keep all five operators to maximize the descriptive power of our statements.
It would be very challenging to read a complex mathematical statement if it were entirely encoded using only the NAND operator.
Mathematics, although formal and technical, is ultimately a language whose purpose is communication between humans, at least for now.

So we mentioned propositional logic. In fact, mathematics is based on something called _predicate logic_,
an extension to propositional logic that includes _predicates_ and _quantifiers_, which we'll discuss next.
Full predicate logic includes all kinds of predicates, but it turns out that mathematics is based on a restricted form of
predicate logic that includes #underline[only four predicates]. These were alluded to earlier when we talked about the four kinds
of mathematical statements. They are $=$, $in$, $#true$, and $#false$.
The first two have placeholders omn either side which accept the names of objects,
so that you can write two objects are equal, $a=b$,
and you can write that one object is a member of another _set_ object, $a in S$.
It is the predicates that connect the language of logic to the mathematical objects so that you can form mathematical statements.

I like to say predicate logic represents the place where the _logical rubber meets the mathematical road_.


== Quantifiers

Before we look at the objects that are directly related to Taylor's theorem, let's briefly talk about the most important piece of
mathematical machinery that you've (probably) never heard of, _quantifiers_.

Maybe at some point during your mathematical education you asked how do I know which letters in an expression or an equation
represent variables and which represent constants?
For example, in the general quadratic $a x^2 + b x + c = 0$ we know that $x$ represents the variable
while $a$, $b$, and $c$ represent constants.
But how do we know that?

I'll bet you were told that it is _customary_, or a _convention_, to choose letters
from the end of the alphabet as variables and letters from the beginning of the alphabet as constants, and that's how you know.
While it is true that there is a convention, it is not strictly the case that the convention tells us which letter, or symbols
are variables. The full story involves quantifiers.

You may be surprised to learn that just like objects, all mathematical variables, which are sometimes called _indeterminates_ or _unknowns_,
must introduced or _declared_ prior to their use and that this declaration is done via quantifiers.

There are only two quantifiers, the universal quantifier, represented by the symbol $forall$,
and the existential quantifier, represented by the symbol $exists$.
Quantifiers tell you which letters, or possibly words or symbols, are being used as variables in a given mathematical statement,
and very importantly they tell you the _type_ of the variable, that is the type of number or object that the variable can contain.
Also, quantifiers tell you the role of the variable as it relates to the truth of the statement.
The universal quantifier tells you that the statement must be true for all values of the variable.
The existential quantifier tells you that the statement must be true for at least one value of the variable.
If the quantified statement does not meet these conditions then the statement is false.

We use the universal quantifier to write statements that are true for all values of the variable.
These kinds of statements are known as _identities_. Here are a couple of identities:

$ forall x:RR {x+x=2x} $
$ forall theta:RR {sin^2 theta + cos^2 theta = 1} $

In the first one, the $forall$ symbol is followed by a declaration of the $x$ variable and we're saying that the statement inside the curly
braces must be true for all values of the variable in order for the whole quantified statement to be true.

In the second, one the $forall$ symbol is followed by a declaration of the $theta$ (greek letter theta) variable and again
we're saying that the statement inside the curly braces must be true for all values of the variable
in order for the whole quantified statement to be true.

We use the existential quantifier to write statements that are true for one or more values of the variable.
These kinds of statements are known as _conditional statements_. Here are a couple of conditional statements:

$ exists x:RR {x+5 = 9} $
$ exists x:RR {x^2 + 3 x + 2 = 0} $

Again, we have the declaration of the $x$ variable immediately following the $exists$ symbol.
The first statement is true only if $x$ is equal to 4.
The second statement is true only if $x$ is equal to -1 or -2.
Thus, in each case the truth of the statement is _conditional_ on which value we assign to the variable.

In some sense, the existential quantifier can be viewed as an invitation, or an instruction, to solve for the variable,
that is, to discover which values that when assigned to the variable make the statement in curly braces true.

I should mention that a mathematical statement that is never true regardless of what values we assign to the variable is called
a _contradiction_. The statement is always false. Here's an example:

$ exists x:RR {x+1 = x} $

Ok, with the discussion of mathematical fundamentals out of the way, let's move on to the main topic of this paper.


= Objects relevant to Taylor's theorem

It's time to talk about the mathematical objects that are directly related to Taylor's theorem.
Let's begin by laying out all of our _mathematical equipment_ on our workbench, so to speak, and look at each part to understand
what it is and how it works.

I should mention up front that all of the objects we're about to discuss come in _multivariate_ versions,
but here we'll restrict our attention to the single variable (_univariate_) versions because
that's all we'll need to define the superstars of the function world -- sine, cosine, and exponential ($e^x$) -- in terms of Taylor series.

== Polynomial functions

A polynomial function is a function whose body is a #underline[finite] sum of terms where each term is the product of a coefficient and
a variable raised to a natural number (positive integer) power.
Here's an example:

$ f(x) = x^2 + 3 x + 2 $

We should give the formal definition of the function by declaring it first and then state how it behaves using
the universal quantifier discussed earlier, so let's do that now.

$
& f:RR -> RR; \
& forall x:RR {f(x) = x^2 + 3 x + 2}; \
$

In this example, the function is _real_, meaning that it takes a real number as its input and returns a real number
as its output, and as you can see the function is defined that way.
However, if someone hands you some random polynomial function, it is usually assumed to be _complex_,
because that's the most general type of polynomial function. Here is how that looks in our formal language:

$
& f:CC -> CC; \
& forall x:CC {f(x) = x^2 + 3 x + 2}; \
$

We can classify any polynomial function in several ways:

- by the type of the coefficients
- by the number of terms
- by the highest power of any of the terms
- by the number of variables

A polynomial function with integer coefficients is called an _integer polynomial function_.
One with real coefficients is called a _real polynomial function_,
and one with complex coefficients is called a _complex polynomial function_.

Polynomial functions with one, two, or three terms are called _monomial_, _binomial_, or _trinomial_ respectively.
Sometimes a polynomial function with two or more terms is called a _multinomial_ polynomial function.

The highest power of the variable in any term is called the _degree_ of the polynomial function.
Polynomial functions with degree 1, 2, and 3 are called linear, quadratic, and cubic, respectively,
and one with degree zero is just a constant.

You can also have polynomial functions with more than one variable, but as mentioned earlier we're only going to be talking
about single variable, _univariate_, functions here.

If we want to write a general polynomial function concisely, we can use sigma notation like this:

$ sum_(k=0)^n a_k x^k $

Here, $k$ is an index that runs from zero up to and including the degree $n$.

The coefficient on each term is represented by $a_k$, which is the $k$#super[th] coefficient,
and $a_k$ is nothing more than a function from the natural numbers into the real or complex numbers
like this:

$
& a:NN -> CC; \
$

It's also common to represent a general polynomial function with a function parameterized by the degree $n$ like this:

$ P_n(x) = sum_(k=0)^n a_k x^k $

== Taylor polynomials

The whole point of the Taylor polynomial is to approximate some function $f$ at some point $c$,
called the center, using a polynomial function. The reason for doing this is because polynomial functions are easy to compute.
And, the more terms we add to the Taylor polynomial the better the approximation becomes.
In fact, Taylor's theorem quantifies precisely how much better the approximation gets as you add more terms.

Let's start by describing what the Taylor polynomial actually is and how it's built,
and then we'll go over the reason why it's built the way it is.

The Taylor polynomial is just a polynomial function with special coefficients.
Here's what those special coefficients look like:

$ (f^((k))(c))/k! $

The coefficient is the $k$#super[th] derivative of the function $f$ -- the one we're trying to approximate --
applied to some constant $c$, called the _center_,
all divided by the factorial of $k$, where $k$ is an index that runs from zero up to and including the degree of the polynomial function.
Here's what each term of a Taylor polynomial looks like:

$ (f^((k))(c))/k! (x-c)^k $

Let's say we want a Taylor polynomial of degree 3.
Here's what that would look like:

$ (f^((0))(c))/0! (x-c)^0  + (f^((1))(c))/1! (x-c)^1 + (f^((2))(c))/2! (x-c)^2 + (f^((3))(c))/3! (x-c)^3 $

See how $k$ runs from zero up to and including 3.
But wait a second! Is that really a polynomial function? I mean each term has a coefficient but it's multiplying $(x-c)$ not $x$. Hmm...
Well, yes it is a polynomial function, but to see why we'll need to expand some of the terms.

The first term ($k=0$) is just $f(c)$, because $ f^((0)) = f$, $0! = 1$, and $(x-c)^0=1$. So the first term is just a constant.

If you distribute the coefficient over $(x-c)^1$, the next term ($k=1$) looks like this:

$ (f^((1))(c))/1! x - (f^((1))(c))/1! c $

This is a polynomial function of degree 1.

If you expand $(x-c)^2$ and distribute the coefficient, the third term ($k=2$) looks like this:

$ (f^((2))(c))/2! x^2 - (f^((2))(c))/2! 2x c + (f^((2))(c))/2! c^2 $

It's still a polynomial function, this time of degree 2.

So each one of these expansions is by itself a polynomial function, and if we add them all together we still have a polynomial function.
In other words, the Taylor polynomial is indeed a polynomial function.

Now you may have one other nagging doubt regarding the Taylor polynomial.
If the goal is to use the Taylor polynomial and its unbounded version the Taylor series, to _define_ the function $f$,
how do we know the derivatives of $f$ before we have the definition?
That's a good question, and one we'll address later when we develop the Taylor series for the sine function from scratch,
so hold that thought for now.

Going forward we don't want to have to write out every Taylor polynomial in long form,
so of course we'll make use of sigma notation to express things more concisely.
For the Taylor polynomial of degree 3 that we showed earlier, the sigma notation version looks like this:

$ sum_(k=0)^3 (f^((k))(c))/k! (x-c)^k $

In general, for some $n$-degree Taylor polynomial the sigma notation version looks like this:

$ sum_(k=0)^n (f^((k))(c))/k! (x-c)^k $

We can make things even more concise by using a notation parameterized by the degree $n$ and the center $c$:

$ T_(n,c)(x) = sum_(k=0)^n (f^((k))(c))/k! (x-c)^k $

Of course, the Taylor polynomial is just a special case of the polynomial function that we discussed previously,
so I should give the excruciatingly formal definition of it, and since in this paper we'll only be discussing real Taylor polynomials
I'll _keep it real_.
Here's the formal definition of the function:

$
& T_(n,c):RR -> RR; \
& forall x:RR {T_(n,c)(x) = sum_(k=0)^n (f^((k))(c))/k! (x-c)^k}; \
$

There's one last thing to mention before we move on.
Some authors like to call the center point the _anchor point_ and they usually denote it with the letter $a$.

Now let's talk about why the Taylor polynomial is constructed this way.

A long time ago, back in the early 1700's, a very smart person -- a genius in fact -- Brooke Taylor,
reasoned that if you're trying to approximate an arbitrary function $f$ with a polynomial function at and near some point $c$, the center,
you should probably construct your polynomial function so that it matches the first few derivatives of $f$ at the point $c$.
That way, not only will $f$ and your polynomial function match exactly at point $c$, but in some neighborhood _around_ $c$
the slopes of the functions will match, their curvatures will match, and so on.
The more terms you add to your approximating polynomial function, the more of its properties will match those of $f$
and therefore the more closely it will approximate $f$.
The Taylor polynomial $T_(n,c)$ is purposely designed so that it matches the value of $f$ at $c$
and similarly all of its derivatives match those of $f$ at $c$
up to and including the $n$#super[th] derivative.

Let's look at an example to see how this works.
Suppose we want to approximate the function $f(x) = x^4$ at 2 (our chosen center) with a Taylor polynomial.
IRL we probably wouldn't ever do this because $x^4$ is simple enough to calculate,
and of course $x^4$ is already a polynomial function,
but this example is just for demonstration purposes.

Ok, let's start by listing the first four derivatives of $x^4$ along with the values of those derivatives evaluated at our center 2.
By the way, I'm counting the zeroth derivative, i.e. $f^((0))$, as the first one. This is just the function itself.
Here's what we get:

$
& f^((0))(x) = x^4      #h(8em)     & f^((0))(2) = 16 \
& f^((1))(x) = 4x^3     #h(8em)     & f^((1))(2) = 32 \
& f^((2))(x) = 12x^2    #h(8em)     & f^((2))(2) = 48 \
& f^((3))(x) = 24x      #h(8em)     & f^((3))(2) = 48 \
$

Now here is Taylor polynomial of degree 3 centered at 2, i.e. $T_(3,2)(x)$, for $x^4$:

$ ((x^4)^((0))(2))/0! (x-2)^0  + ((x^4)^((1))(2))/1! (x-2)^1 + ((x^4)^((2))(2))/2! (x-2)^2 + ((x^4)^((3))(2))/3! (x-2)^3 wide $

We have already listed the first four derivatives of $x^4$ evaluated at 2 so let's substitute those values in now:

$ 16/0! (x-2)^0  + 32/1! (x-2)^1 + 48/2! (x-2)^2 + 48/3! (x-2)^3 $

Finally, doing some arithmetic (recall $0! = 1$, $1! = 1$, and $(x-2)^0 = 1$) we get:

$ T_(3,2)(x) = 16 + 32 (x-2)^1 + 24 (x-2)^2 + 8 (x-2)^3 $

Now let's compute the first four derivatives of our Taylor polynomial, and again I'm counting the zeroth derivative as the first one.
We're going to use the chain rule here, so you may be thinking that things are about to get complicated.
However, it turns out that because the inner function in each term is $(x-2)$, its derivative is just 1,
so that we can, for all intents and purposes, ignore the chain rule and just differentiate the outer function of each term.

$
& T_(3,2)(x)^((0)) = 16 + 32 (x-2)^1 + 24 (x-2)^2 + 8 (x-2)^3 \
& T_(3,2)(x)^((1)) = 32 + 48 (x-2)^1 + 24 (x-2)^2 \
& T_(3,2)(x)^((2)) = 48 + 48 (x-2)^1 \
& T_(3,2)(x)^((3)) = 48 \
$

Remember that Brooke Taylor's original idea was that the derivatives of the Taylor polynomial should match the derivatives of the function
we're approximating exactly at $c$, so the four derivatives of our $T_(3,2)(x)$ better match the derivatives of $x^4$ exactly at 2;
otherwise we'll have old Brooke to answer to.
Let's check that now:

$
& T_(3,2)(2)^((0)) = 16 \
& T_(3,2)(2)^((1)) = 32 \
& T_(3,2)(2)^((2)) = 48 \
& T_(3,2)(2)^((3)) = 48 \
$

They match perfectly. Good!

According to Brooke Taylor, the fact that the first four derivatives of our Taylor polynomial match the first four derivatives of $x^4$
should make $T_(3,2)(x)$ a pretty good approximation of $x^4$ in the neighborhood of 2.
At this point, you'd be justified in asking what do I mean by _neighborhood_, and it's fair to say I have been a bit hand-wavy
on this terminology so far.
The precise meaning of neighborhood and how good of an approximation the Taylor polynomial is to the function is precisely the topic
of Taylor's theorem, so let's put a pin in that question for now.

To get a visual of how the approximation works, it's helpful to examine the system in a graphing calculator.
We'll assume Desmos here, but there are other graphing solutions like Geogebra or Wolfram Alpha.

Start by copy-pasting the target function $f(x) = x^4$ and the
Taylor Polynomial \
$T_(3,2)(x) = 16 + 32 (x-2)^1 + 24 (x-2)^2 + 8 (x-2)^3$
into Desmos cells.
Unfortunately, Desmos doesn't allow more than one subscript on function names, so you'll need
to name the Taylor polynomial function something like $T(x)$.
You'll notice immediately that the approximation is really good at and around $c=2$ for degree $n=3$.
But what about for other values of $c$ and $n$?
You study what happens at other values by setting up a _general_ Taylor polynomial in Desmos.
Be warned, the set up is a bit clunky.
Here's how.

First, you'll need a couple of sliders for $n$ and $c$.

Next you'll need to enter a list of derivatives of $f$ evaluated at $c$:

$ D = [f(c), f'(c), f''(c), f'''(c), f''''(c), f'''''(c), f''''''(c), f'''''''(c)] $

Desmos doesn't support the superscript notation for derivatives, so you have no choice but to use all those primes.

Finally, enter the general Taylor polynomial itself:

$ T(x) = sum_(k=0)^n D[k+1]/k! (x-c)^k $

Note: Desmos uses 1-based indexing for lists. That's why we have $D[k+1]$ instead of $D[k]$ in the coefficient.

Playing around with the sliders you'll discover a couple interesting things.

First, for $n=3$ the approximation is really good for $c!=0$, but at $c=0$, $T(x)$ is just zero everywhere.
Not good, but you can see why: $x^4$ and all of its derivatives are equal to zero when evaluated at zero.
That makes the whole approximation equal to zero for $c=0$.
This is not always the case however. For many functions, the approximation is very good at $c=0$.
In fact, a Taylor polynomial centered at zero has a special name; it's called a Maclaurin polynomial.
You can easily change the target function in your Desmos set up to another one, sine for example, by setting $f(x) = sin(x)$.
Try it and see what happens.

Second, you'll notice that if you increase the degree to 4 or more, the approximation is perfect.
In other words, the Taylor polynomial becomes exactly equal to the target function $x^4$.
Perhaps it's not too surprising that the Taylor polynomial morphs itself into the target polynomial when its degree
matches the degree of the target polynomial function.
This phenomenon underscores why there is little value to approximating polynomial functions with Taylor polynomials.
The real pay off comes with approximating other kinds of functions, such as the transcendental functions
$sin x$, $cos x$, and $e^x$.

Ok, so that about wraps it up for Taylor polynomials.
A Taylor polynomial is nothing more than an ordinary polynomial function with special coefficients engineered
so that when evaluated at the center $c$,
the value and the values of the first $n$ derivatives match those of the function being approximated.
We left a couple of questions regarding neighborhoods and how to get the derivatives of $f$ unresolved,
but we'll address those in due course.

== Power series

You can think of a power series as an infinite version of a polynomial function,
with an infinite number of terms and an infinite degree.
Here is the definition using sigma notation:

$ sum_(n=0)^oo a_n (x-c)^n $ <exp:power_series>

Strictly speaking, a power series is not a polynomial function, because, as you may recall, the defining characteristics of
polynomial functions is that they have a finite number of terms and a finite degree.
Just like with polynomial functions, there is an index, but this time the index runs from zero all the way to infinity.
For this reason, we usually name the index $n$ as opposed to $k$.
And just like with polynomial functions, there is a coefficient $a_n$, which again is a function from the natural numbers to the real
or complex numbers.
Notice, however, that there is a new feature, the center $c$.
Because power series have an infinite number of terms, we have to worry about _convergence_, so let's talk about that now.

Technically, the sigma notation we used in @exp:power_series[expression] is not quite right.
In fact, what we wrote is a kind of notational convenience, sometimes called _abuse of notation_, that's more or less
suggestive of the meaning we intend.
The problem is the infinity symbol $oo$ on top of the $sum$ symbol, which suggests a completed infinity, whereas what we actually
want is the value that the sum approaches as $n$ increases without bound. In other words, we need a limit, like this:

$ lim_(n->oo) sum_(k=0)^n a_k (x-c)^k $ <exp:power_series_limit>

If you're familiar with calculus,
you may recognize the similarity of the notational convenience to an improper integral which is also essentially a limit.

== Taylor series





#pagebreak()

= Euler's solution to the Basel problem <sec:solution>

Euler solved the Basel problem by proving the following theorem.

#theorem(title: "Basel problem")[$ sum_(n=1)^oo 1/n^2 = pi^2/6 $] <thm:basel_problem>

== Proof

The sine function is defined analytically by the Maclaurin series

$ sin x = x - x^3/3! + x^5/5! - x^7/7! + dots.c . $ <eq:maclaurin_series_for_sin>

Maclaurin series are a special type of power series.
Since polynomial functions — which, by definition, contain only finitely many terms — can also be viewed as finite power series,
Euler reasoned that the Maclaurin series for the sine function could be manipulated in much the same way as a polynomial.
In particular, he treated it as though it could be factorized into a constant multiplied by infinitely many linear factors.
Although this approach was controversial at the time, it was later placed on a firm mathematical foundation
with the publication of Karl Weierstrass’s factorization theorem in 1876.

Polynomial functions may be re-expressed via factorization
as the product of a constant, a finite number of real linear factors, and a finite number of irreducible real quadratics.
The irreducible real quadratics appear only when the polynomial function has one or more non-real, complex zeros.
If the polynomial has all real zeros, then it can be expressed solely as the product of a constant and a finite number real linear factors. \
For example, the polynomial function $f(x) = 2x^2 - 14x + 24$, which has real zeros 3 and 4, may be expressed as $f(x) = 2(x-3)(x-4)$.
In the polynomial case, the constant is simply the leading coefficient, i.e., the coefficient of the highest degree term.
In the case of power series however, since there are infinitely many terms, there is no _highest degree term_ and thus no leading coefficient.
The constant is still part of the factorization of the power series; it's just that we can't determine it by looking at the highest
degree term and we need to use a different technique to extract it, as we'll see later in the argument.

Since $sin x$ is zero _only_ at $x=0, plus.minus pi, plus.minus 2pi, plus.minus 3pi, dots$, these values are the zeros of the Maclaurin series.
Note that since the zeros have the form $plus.minus k pi$ for all $k in NN$ and are thus all real,
the series can be expressed as the product of a constant $c$ and infinitely many real linear factors of \
the form $(x plus.minus k pi)$.
It is these zeros that explain why $pi$ appears in the value of the Basel sum.

#pagebreak()

Thus, we have

$ sin x = c (x-0)(x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) dots.c $
$ sin x = c x(x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) dots.c $
$ (sin x)/x = c (x-pi)(x+pi)(x-2pi)(x+2pi)(x-3pi)(x+3pi) dots.c $
$ (sin x)/x = c (x^2 - pi^2)(x^2 - 4pi^2)(x^2 - 9pi^2 ) dots.c wide "(difference of squares)," $ <eq:diff_of_squares>

for some constant $c$.

The next step is to determine the value of the constant $c$. \
At $x=0$, $(sin x)/x = 0/0$, which is undefined, but in the context of limits $0/0$ is an indeterminate form,
so we are permitted to take the limit of both sides as $x$ goes to zero.
Taking the limit we get

$ lim_(x->0) (sin x)/x = lim_(x->0) c (x^2 - pi^2)(x^2 - 4pi^2)(x^2 - 9pi^2 ) dots.c . $

The limit of the left side is simply 1, i.e., $lim_(x->0) (sin x)/x = 1$,
which can be verified through a simple application of L'Hospital's rule.
Thus, we have

$ 1 = c (- pi^2)(- 4pi^2)(- 9pi^2) dots.c $
$ c = 1 / ((- pi^2)(- 4pi^2)(- 9pi^2) dots.c) $
$ c = (1 / (- pi^2)) (1 / (- 4pi^2)) (1 / (- 9pi^2)) dots.c . $

Pairing each factor of $c$ with its matching difference of squares factor from @eq:diff_of_squares, we get

$ (sin x)/x = (1 / (- pi^2))(x^2 - pi^2) (1 / (- 4pi^2))(x^2 - 4pi^2) (1 / (- 9pi^2))(x^2 - 9pi^2 ) dots.c $
$ (sin x)/x = (1-x^2/(pi^2)) (1-x^2/(4pi^2)) (1-x^2/(9pi^2)) dots.c . $ <eq:weierstrass>

As a brief aside, we should note that @eq:weierstrass is equivalent to Weierstrass's factorization of $sin x$.

$ sin x = x product_(n=1)^oo [1-x^2/(n^2 pi^2)] wide "Weierstrass factorization" $

#pagebreak()

Indeed, we could have used Weierstrass as our starting point for the proof.
However, since we are following Euler's development of the argument, we chose to begin with the Maclaurin series for sine.

If we progressively FOIL a number of factors of the infinite product on the right-hand side of @eq:weierstrass from left to right we get

$ (1-x^2/(pi^2)) (1-x^2/(4pi^2)) (1-x^2/(9pi^2)) $ <exp:foil_1>
$ (1-x^2/(pi^2) - x^2/(4pi^2) + x^4/(4pi^4)) (1-x^2/(9pi^2)) $ <exp:foil_2>
$ (1-x^2/(pi^2) - x^2/(4pi^2) + x^4/(4pi^4) - x^2/(9pi^2) + x^4/(9pi^4) + x^4/(36pi^4) - x^6/(36pi^6)) . $ <exp:foil_3>

Regrouping @exp:foil_3[expression] so that the matching terms are adjacent, we get

$ 1-x^2/(pi^2) - x^2/(4pi^2) - x^2/(9pi^2) + x^4/(4pi^4) + x^4/(9pi^4) + x^4/(36pi^4) - x^6/(36pi^6) $
$ 1 - (x^2/(pi^2) + x^2/(4pi^2) + x^2/(9pi^2)) + (x^4/(4pi^4) + x^4/(9pi^4) + x^4/(36pi^4)) - (x^6/(36pi^6)) $
$ 1 - x^2/pi^2(1/1 + 1/4 + 1/9) + x^4/pi^4(1/4 + 1/9 + 1/36) - x^6/pi^6(1/36) . $

Continuing this process indefinitely, we end up with a sum of the form

$
1 -
x^2/pi^2(1/1 + 1/4 + 1/9 + dots.c) +
x^4/pi^4(1/4 + 1/9 + 1/36 + dots.c) -
x^6/pi^6(1/36 + dots.c) +
dots.c .
$ <exp:foil_infinite>

We'll set $S_2, S_4, "and" S_6$ equal to the sums in the $x^2, x^4, "and" x^6$ terms respectively.\
We'll set $C_2, C_4, "and" C_6$ equal to the coefficients of the $x^2, x^4, "and" x^6$ terms respectively,\
such that $C_2 = 1/pi^2 S_2, C_4 = 1/pi^4 S_6, "and" C_6 =  1/pi^6 S_6$.

The $S_2$ factor of the $C_2$ coefficient is the sum of reciprocal squares that we're aiming to compute, i.e.,

$ S_2 = sum_(n=1)^oo 1/n^2 . $

The $S_4$ and $S_6$ sums are more complicated, involving double and triple sums respectively,
but since we're only interested in the $S_2$ sum, we won't need $S_4$ and $S_6$.

#pagebreak()

Rewriting the @exp:foil_infinite[expression] using the coefficients $C_2, C_4, "and" C_6$ defined earlier, we get

$
1 -
x^2 C_2 +
x^4 C_4 -
x^6 C_6 +
dots.c .
$

Per @eq:weierstrass, this sum is equal to $(sin x)/x$, so we have

$
(sin x)/x =
1 -
x^2 C_2 +
x^4 C_4 -
x^6 C_6 +
dots.c .
$ <eq:sum_of_sums>

Recalling the Maclaurin series for sine from @eq:maclaurin_series_for_sin and dividing both sides by $x$ we get

$ (sin x)/x = 1 - x^2/3! + x^4/5! - x^6/7! + dots.c . $ <eq:maclaurin_series_for_sin_over_x>

Now we have two representations of $(sin x)/x$.

Equating the coefficients of the $x^2$ terms from @eq:sum_of_sums and @eq:maclaurin_series_for_sin_over_x we get

$ C_2 = 1/3! . $

Rewriting $C_2$ and $S_2$, we get

$ 1/pi^2 S_2 = 1/3! $
$ 1/pi^2 sum_(n=1)^oo 1/n^2 = 1/3! $
$ sum_(n=1)^oo 1/n^2 = pi^2/3! . $

This completes the proof.

= Using Euler's method to prove a related theorem <sec:similar_theorem>

It is instructive to look at Euler's method applied to the $x^4$ terms of the
Maclaurin series and the Weierstrass factorization of the sine function
in order to prove the following theorem.

#theorem(title: "Basel variant")[$ sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2n^2) = pi^4/120 $] <thm:basel_variant>

The proof offers a glimpse of how Euler's method may be generalized to compute the values of sums that are similar to Basel sum.

#pagebreak()

== Proof

We begin by recalling @eq:weierstrass, which as noted earlier is a form of Weierstrass's factorization of sine,

#restate(<eq:weierstrass>)

We are interested in the $x^4$ terms in the expansion of the right-hand side of @eq:weierstrass.
These terms can only arise from the multiplication of pairs of factors containing $x^2$ terms.
Let's expand a simpler product with just four factors to see if we can observe a pattern.

$
(1 - a x^2)(1 - b x^2)(1 - c x^2)(1 - d x^2) \
= (1 - a x^2 - b x^2 + a b x^4)(1 - c x^2)(1 - d x^2) \
= (1 - a x^2 - b x^2 + a b x^4 - c x^2 + a c x^4 + b c x^4 - a b c x^6)(1 - d x^2) \
= 1 - a x^2 - b x^2 + a b x^4 - c x^2 + a c x^4 + b c x^4 - a b c x^6 \
    - d x^2 + a d x^4 + b d x^4 - a b d x^6 + c d x^4 - a c d x^6 - b c d x^6 + a b c d x^8
$ <exp:initial_expansion>

Regrouping the 16 terms of @exp:initial_expansion[expression] we get

$
& 1 & wide binom(4,0) = 1 "term " \ 
& - a x^2 - b x^2  - c x^2 - d x^2 & wide binom(4,1) = 4 "terms"  \
& + a b x^4 + a c x^4 + b c x^4 + a d x^4 + b d x^4  + c d x^4 & wide binom(4,2) = 6 "terms" \
& - a b c x^6 - a b d x^6 - a c d x^6 - b c d x^6 & wide binom(4,3) = 4 "terms" \
& + a b c d x^8 & wide binom(4,4) = 1 "term."
$ <exp:full_expansion>

We note that the coefficients of the $x^4$ terms in @exp:full_expansion[expression] are the products of every #box([_2-combination_])
drawn from the set of coefficients of the $x^2$ terms, ${a,b,c,d}$.
That is, they are the products of every possible pair drawn from ${a,b,c,d}$ where the order does not matter and there are no repeats.

Translating this pattern to the situation in @eq:weierstrass, where the coefficients of the $x^2$ terms have the form $1/(k^2pi^2)$,
we need to sum the products of every possible pair of reciprocal square coefficients,
such that the order does not matter and there are no repeats.

#pagebreak()

To get the required sum of products, we'll need two indexes, say $m$ and $n$, with appropriate constraints applied so that we have

$ sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2 pi^2) x^2 1/(n^2 pi^2) x^2 . $ <exp:sum_of_reciprocal_products>

Here, for each $m$ we run through every $n$ that is greater than $m$.
Another option would be to run through every $n$ less than $m$, but in that case we would have to start $m$ at 2.
Ultimately, it doesn't matter which indexing scheme we choose as long as $m != n$ and that either $m < n$ or $m > n$, but not both.
Rewriting @exp:sum_of_reciprocal_products[expression], we get

$ x^4/pi^4 sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2 n^2) . $ <exp:sum_of_reciprocal_products_final>

Recalling @eq:maclaurin_series_for_sin_over_x, we have

#restate(<eq:maclaurin_series_for_sin_over_x>)

We can equate the coefficient of the $x^4$ term in the Maclaurin series on the right-hand side of @eq:maclaurin_series_for_sin_over_x
with the coefficient of the $x^4$ term in @exp:sum_of_reciprocal_products_final[expression] to get

$ 1/pi^4 sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2 n^2) = 1/5! . $

Rewriting leads to the following statement which completes the proof.

$ sum_(m=1)^oo sum_(n=m+1)^oo 1/(m^2 n^2) = pi^4/5! $

#pagebreak()

= Evaluating the 4-series

Armed with the previous results, we can easily evaluate the 4-series.

#theorem(title: "Sum of the 4-series")[$ sum_(n=1)^oo 1/(n^4) = pi^4/90 $] <thm:sum_of_4-series>

== Proof

We begin by using the Basel sum to evaluate the double sum

$ sum_(m=1)^oo sum_(n=1)^oo 1/(m^2 n^2) , $ <exp:double_sum_reciprocal_product_squares>

which is the sum of all reciprocals of the product of two squares of a natural number greater than zero.
Note that this double sum is different from the one in @thm:basel_variant[theorem] because here the indexes are _unrestricted_,
that is, $n$ does not depend on $m$.

Clearly, we can rewrite the double sum as

$ sum_(m=1)^oo sum_(n=1)^oo 1/m^2 1/n^2 . $

And, since the $1/m^2$ term is not captured by the $n$ index of the inner sum, we can move it outside the inner sum to get

$ sum_(m=1)^oo (1/m^2 sum_(n=1)^oo 1/n^2) . $

Now in @thm:basel_problem[theorem], the Basel problem theorem, we showed that the Basel sum, $sum_(n=1)^oo 1/n^2$, converges to $pi^2/6$,
so it is effectively just a constant multiplying each $1/m^2$ term, and thus by the distributive property, we can move it outside the outer sum to get

$ sum_(n=1)^oo 1/n^2 dot sum_(m=1)^oo 1/m^2 . $

In fact, this is a general result, so that we can always rewrite the double sum of a product as the product of a sum, provided that the two series are convergent.

Finally, since we know that both series in the product evaluate to $pi^2/6$, we have

$ sum_(m=1)^oo sum_(n=1)^oo 1/(m^2 n^2) = pi^4/36 . $ <eq:double_sum_reciprocal_product_squares>

#pagebreak()

@fig:reciprocal-product-of-squares depicts the terms of @exp:double_sum_reciprocal_product_squares[series] arranged in a grid.

// Define the function that renders the content for each (i,j) cell.
#let reciprocal-product-of-squares(i, j) = $ 1/(#i^2 #j^2) $

// Alternatively, we can use a lambda abstraction for the expression function.
// #number-array(4, 4, (i, j) => $ 1/(#i^2 #j^2) $ )

// Create the number array table and render it inside a figure.
#let number-array = number-array(5, 5,
                                 reciprocal-product-of-squares,
                                 upper-triangle-hl: hl-yellow,
                                 diagonal-hl: hl-pink,
                                 lower-triangle-hl: hl-green,
                                 ellipsis: true)

#figure(number-array, caption: [Sum of reciprocal product squares]) <fig:reciprocal-product-of-squares>

Observe that the sum of the terms in upper triangle, highlighted in yellow, is the sum of @thm:basel_variant[theorem], that is, $pi^4/120$,
and by symmetry the sum of the terms in the lower triangle, highlighted in green, has the the same value, also $pi^4/120$.

The terms along the major diagonal, highlighted in pink, satisfy $m=n$.
Thus the sum of the terms along the major diagonal is

$ sum_(n=1)^oo 1/(n^2 n^2) = sum_(n=1)^oo 1/n^4  , $

which is the series we are looking to evaluate.

To compute the sum of the terms along the major diagonal we can subtract the sums of the upper and lower triangles, each $pi^4/120$,
from the sum of all terms in the table, which we already showed in @eq:double_sum_reciprocal_product_squares is equal to $pi^4/36$.

Thus we have

$ sum_(n=1)^oo 1/n^4 =  pi^4/36 - 2pi^4/120 = 10pi^4/360 - 6pi^4/360 = 4pi^4/360 = pi^4/90 , $

which concludes the proof.

#pagebreak()

= Conclusion <sec:conclusion>

Euler's remarkable insight in solving the Basel problem was recognizing that the coefficients of like terms could be equated
from two different representations of the function $(sin x)/x$.
The Maclaurin series representation of sine was well known at the time of Euler's work.
However, to establish a second representation of $(sin x)/x$, Euler assumed that sine could be expressed
as an infinite product.
His assumption anticipated Weierstrass's factorization theorem published in 1876 as part of a work on the theory of analytic functions.
As noted in the introduction, Euler's method was an important step towards understanding p-series in general,
and in particular can be used to compute the values of all p-series where p is a non-zero even natural number.
Although many tests exist that determine whether a series converges or diverges,
explicitly calculating the value of a series is often challenging.
Euler's method therefore is a significant contribution to mathematics
because it provides a tool for evaluating a whole class of p-series and related infinite series.