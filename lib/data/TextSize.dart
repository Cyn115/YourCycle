enum Sizes { small, medium, large }

class Size {
  final int titlesize; 
  final double headingsize;
  final int subheadingsize;
  final int smallbodytextsize;
  final int bigbodytextsize;

  const Size(this.titlesize, this.headingsize, this.subheadingsize,
      this.smallbodytextsize, this.bigbodytextsize);
}

const sizes = {
  Sizes.large: Size(40, 40, 30, 25, 50),
  Sizes.medium: Size(30, 30, 20, 15, 40),
  Sizes.small: Size(25, 25, 15, 10, 35)
};
