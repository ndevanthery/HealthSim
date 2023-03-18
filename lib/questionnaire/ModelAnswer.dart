
//Model where to put the answers
class ModelAnswer {
  int gender, age, height, weight, glyc, highSyst, syst, highChol, chol, hdl,
      diab, inf, avc, afinf, afcancer, smoke, alim, sport, alcool;

  //the constructor
  ModelAnswer(
      this.gender,
      this.age,
      this.height,
      this.weight,
      this.glyc,
      this.highSyst,
      this.syst,
      this.highChol,
      this.chol,
      this.hdl,
      this.diab,
      this.inf,
      this.avc,
      this.afinf,
      this.afcancer,
      this.smoke,
      this.alim,
      this.sport,
      this.alcool);


//Map to put the answers in the database
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String,dynamic>{};
    data["gender"] = gender;
    data["age"] = age;
    data["height"] = height;
    data["weight"] = weight;
    data["glyc"] = glyc;
    data["highChol"] = highChol;
    data["highSyst"] = highSyst;
    data["chol"] = chol;
    data["syst"] = syst;
    data["hdl"] = hdl;
    data["diab"] = diab;
    data["inf"] =inf;
    data["avc"] = avc;
    data["afinf"] = afinf;
    data["afcancer"] = afcancer;
    data["smoke"] = smoke;
    data["alim"] = alim;
    data["sport"] = sport;
    data["alcool"] = alcool;

    return data;
  }

}