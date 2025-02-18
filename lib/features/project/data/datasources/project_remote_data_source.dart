import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/project_model.dart';

part 'project_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class ProjectRemoteDataSource {
  @factoryMethod
  factory ProjectRemoteDataSource(Dio dio) = _ProjectRemoteDataSource;

  @GET('/projects')
  Future<List<ProjectModel>> getProjects();

  @GET('/projects/{id}')
  Future<ProjectModel> getProjectById(@Path('id') String id);

  @POST('/projects')
  Future<ProjectModel> createProject(@Body() ProjectModel project);

  @PUT('/projects/{id}')
  Future<ProjectModel> updateProject(
    @Path('id') String id,
    @Body() ProjectModel project,
  );

  @DELETE('/projects/{id}')
  Future<void> deleteProject(@Path('id') String id);
}
