enum BodyParts {Chest, Hands, Shoulders, Press, Lags, Buttocks, Back}

class BodyPartsValues {

  List ids = [0, 1, 2, 3, 4, 5, 6];

  int getBodyPartsValues(BodyParts s){
    switch (s) {
      case BodyParts.Chest:
        return ids[0];
        break;
      case BodyParts.Hands:
        return ids[1];
        break;
      case BodyParts.Shoulders:
        return ids[2];
        break;
      case BodyParts.Press:
        return ids[3];
        break;
      case BodyParts.Lags:
        return ids[4];
        break;
      case BodyParts.Buttocks:
        return ids[5];
        break;
      case BodyParts.Back:
        return ids[6];
        break;
      default: return -1;
    }

  }

}
