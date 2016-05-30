%function out = model
%
% NS_DG_update3_fortest.m
%
% Model exported on May 30 2016, 15:17 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/yczhang/Documents/comsol_DG_examples/NS_DG/NS_DG_update3');

model.label('NS_DG_update3_fortest.mph');

model.comments(['NS\n\nUsing P2+P1, and Picard''s iteration']);

model.baseSystem('none');

model.param.set('nu', '1', 'dynamical viscosity');
model.param.set('sigma', '10');
model.param.set('eipsilon', '1');
model.param.set('beta', '1');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').run;

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('f1', '0');
model.variable('var2').set('f2', '0');
model.variable('var2').set('g1', '1', '(u''s)Dirichlet B.C.');
model.variable('var2').set('g2', '0', '(v''s)Dirichlet B.C.');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('uexac', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)', 'stokes exact solution');
model.variable('var3').set('vexac', '-x*(x-1)*(2*x-1)*y^2*(y-1)^2', 'stokes exact solution');
model.variable('var3').set('pexac', '(2*x-1)*(2*y-1)', 'stokes exact solution');
model.variable('var3').set('ujump', 'up(u)-down(u)');
model.variable('var3').set('vjump', 'up(v)-down(v)');
model.variable('var3').set('pjump', 'up(p)-down(p)');
model.variable('var3').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var3').set('testvjump', 'test(up(v))-test(down(v))');
model.variable('var3').set('testpjump', 'test(up(p))-test(down(p))');
model.variable('var3').set('unavg', '0.5*((up(d(u,x))+down(d(u,x)))*unx+(up(d(u,y))+down(d(u,y)))*uny)', 'Expression:1/2*{{(d(u,x),d(u,y)) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in boundry edges.');
model.variable('var3').set('vnavg', '0.5*((up(d(v,x))+down(d(v,x)))*unx+(up(d(v,y))+down(d(v,y)))*uny)');
model.variable('var3').set('testunavg', '0.5*((test(up(d(u,x)))+test(down(d(u,x))))*unx+(test(up(d(u,y)))+test(down(d(u,y))))*uny)');
model.variable('var3').set('testvnavg', '0.5*((test(up(d(v,x)))+test(down(d(v,x))))*unx+(test(up(d(v,y)))+test(down(d(v,y))))*uny)');
model.variable('var3').set('pavg', '0.5*(up(p)+down(p))');
model.variable('var3').set('testpavg', '0.5*(test(up(p))+test(down(p)))');
model.variable('var3').set('un', 'd(u,x)*nx+d(u,y)*ny', 'un is used in boundary edges.');
model.variable('var3').set('vn', 'd(v,x)*nx+d(v,y)*ny');
model.variable('var3').set('testun', 'test(d(u,x))*nx+test(d(u,y))*ny', 'testun is used in boundary edges.');
model.variable('var3').set('testvn', 'test(d(v,x))*nx+test(d(v,y))*ny');
model.variable('var3').set('uerr', 'u-uexac');
model.variable('var3').set('verr', 'v-vexac');
model.variable('var3').set('perr', 'p-pexac');
model.variable('var3').set('u_l2err', 'sqrt(a_int(uerr^2))');
model.variable('var3').set('v_l2err', 'sqrt(a_int(verr^2))');
model.variable('var3').set('p_l2err', 'sqrt(a_int(perr^2))');
model.variable('var3').set('uv_l2err', 'sqrt(u_l2err^2+v_l2err^2)');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').set('u1jump', 'up(u1)-down(u1)');
model.variable('var4').set('v1jump', 'up(v1)-down(v1)');
model.variable('var4').set('p1jump', 'up(p1)-down(p1)');
model.variable('var4').set('testu1jump', 'test(up(u1))-test(down(u1))');
model.variable('var4').set('testv1jump', 'test(up(v1))-test(down(v1))');
model.variable('var4').set('testp1jump', 'test(up(p1))-test(down(p1))');
model.variable('var4').set('u1navg', '0.5*((up(u1x)+down(u1x))*unx+(up(u1y)+down(u1y))*uny)', 'Expression:1/2*{{(u1x,u1y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou1ndry edges.');
model.variable('var4').set('v1navg', '0.5*((up(v1x)+down(v1x))*unx+(up(v1y)+down(v1y))*uny)');
model.variable('var4').set('testu1navg', '0.5*((test(up(u1x))+test(down(u1x)))*unx+(test(up(u1y))+test(down(u1y)))*uny)');
model.variable('var4').set('testv1navg', '0.5*((test(up(v1x))+test(down(v1x)))*unx+(test(up(v1y))+test(down(v1y)))*uny)');
model.variable('var4').set('p1avg', '0.5*(up(p1)+down(p1))');
model.variable('var4').set('testp1avg', '0.5*(test(up(p1))+test(down(p1)))');
model.variable('var4').set('u1n', 'u1x*nx+u1y*ny', 'u1n is used in bou1ndary edges.');
model.variable('var4').set('v1n', 'v1x*nx+v1y*ny');
model.variable('var4').set('testu1n', 'test(u1x)*nx+test(u1y)*ny', 'testu1n is used in bou1ndary edges.');
model.variable('var4').set('testv1n', 'test(v1x)*nx+test(v1y)*ny');
model.variable('var4').set('u1err', 'u1-ns_uexac');
model.variable('var4').set('v1err', 'v1-ns_vexac');
model.variable('var4').set('p1err', 'p1-ns_pexac');
model.variable('var4').set('u1_l2err', 'sqrt(a_int(u1err^2))');
model.variable('var4').set('v1_l2err', 'sqrt(a_int(v1err^2))');
model.variable('var4').set('p1_l2err', 'sqrt(a_int(p1err^2))');
model.variable('var4').set('u1v1_l2err', 'sqrt(u1_l2err^2+v1_l2err^2)');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').set('u2jump', 'up(u2)-down(u2)');
model.variable('var5').set('v2jump', 'up(v2)-down(v2)');
model.variable('var5').set('p2jump', 'up(p2)-down(p2)');
model.variable('var5').set('testu2jump', 'test(up(u2))-test(down(u2))');
model.variable('var5').set('testv2jump', 'test(up(v2))-test(down(v2))');
model.variable('var5').set('testp2jump', 'test(up(p2))-test(down(p2))');
model.variable('var5').set('u2navg', '0.5*((up(u2x)+down(u2x))*unx+(up(u2y)+down(u2y))*uny)', 'Expression:1/2*{{(u2x,u2y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou2ndry edges.');
model.variable('var5').set('v2navg', '0.5*((up(v2x)+down(v2x))*unx+(up(v2y)+down(v2y))*uny)');
model.variable('var5').set('testu2navg', '0.5*((test(up(u2x))+test(down(u2x)))*unx+(test(up(u2y))+test(down(u2y)))*uny)');
model.variable('var5').set('testv2navg', '0.5*((test(up(v2x))+test(down(v2x)))*unx+(test(up(v2y))+test(down(v2y)))*uny)');
model.variable('var5').set('p2avg', '0.5*(up(p2)+down(p2))');
model.variable('var5').set('testp2avg', '0.5*(test(up(p2))+test(down(p2)))');
model.variable('var5').set('u2n', 'u2x*nx+u2y*ny', 'u2n is used in bou2ndary edges.');
model.variable('var5').set('v2n', 'v2x*nx+v2y*ny');
model.variable('var5').set('testu2n', 'test(u2x)*nx+test(u2y)*ny', 'testu2n is used in bou2ndary edges.');
model.variable('var5').set('testv2n', 'test(v2x)*nx+test(v2y)*ny');
model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('ujump', 'up(u)-down(u)');
model.variable('var1').set('vjump', 'up(v)-down(v)');
model.variable('var1').set('pjump', 'up(p)-down(p)');
model.variable('var1').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var1').set('testvjump', 'test(up(v))-test(down(v))');
model.variable('var1').set('testpjump', 'test(up(p))-test(down(p))');
model.variable('var1').set('unavg', '0.5*((up(d(u,x))+down(d(u,x)))*unx+(up(d(u,y))+down(d(u,y)))*uny)');
model.variable('var1').set('vnavg', '0.5*((up(d(v,x))+down(d(v,x)))*unx+(up(d(v,y))+down(d(v,y)))*uny)');
model.variable('var1').set('testunavg', '0.5*((test(up(d(u,x)))+test(down(d(u,x))))*unx+(test(up(d(u,y)))+test(down(d(u,y))))*uny)');
model.variable('var1').set('testvnavg', '0.5*((test(up(d(v,x)))+test(down(d(v,x))))*unx+(test(up(d(v,y)))+test(down(d(v,y))))*uny)');
model.variable('var1').set('pavg', '0.5*(up(p)+down(p))');
model.variable('var1').set('f1', '2*(2*y - 1)*(- 3*nu*x^4 + 6*nu*x^3 - 6*nu*x^2*y^2 + 6*nu*x^2*y - 3*nu*x^2 + 6*nu*x*y^2 - 6*nu*x*y - nu*y^2 + nu*y + 1)');
model.variable('var1').set('f2', '2*(2*x - 1)*(6*nu*x^2*y^2 - 6*nu*x^2*y + nu*x^2 - 6*nu*x*y^2 + 6*nu*x*y - nu*x + 3*nu*y^4 - 6*nu*y^3 + 3*nu*y^2 + 1)');
model.variable('var1').set('uexac', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)');
model.variable('var1').set('g1', '0');
model.variable('var1').set('g2', '0');
model.variable('var1').set('testpavg', '0.5*(test(up(p))+test(down(p)))');
model.variable('var1').set('testun', 'test(d(u,x))*nx+test(d(u,y))*ny');
model.variable('var1').set('testvn', 'test(d(v,x))*nx+test(d(v,y))*ny');
model.variable('var1').set('un', 'd(u,x)*nx+d(u,y)*ny');
model.variable('var1').set('vn', 'd(v,x)*nx+d(v,y)*ny');
model.variable('var1').set('vexac', '-x*(x-1)*(2*x-1)*y^2*(y-1)^2');
model.variable('var1').set('uerr', 'u-uexac');
model.variable('var1').set('u_l2err', 'sqrt(intop1(uerr^2))');
model.variable('var1').set('verr', 'v-vexac');
model.variable('var1').set('v_l2err', 'sqrt(intop1(verr^2))');
model.variable('var1').set('uv_l2err', 'sqrt(u_l2err^2+v_l2err^2)');

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 3);
model.view.create('view5', 3);
model.view.create('view6', 3);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').selection.all;

model.physics.create('u_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u_weak_func').identifier('u_weak_func');
model.physics('u_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u_weak_func').feature('ibweak1').selection.all;
model.physics('u_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u_weak_func').feature('weak1').selection.set([3]);
model.physics('u_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('v_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v_weak_func').identifier('v_weak_func');
model.physics('v_weak_func').field('dimensionless').field('v');
model.physics('v_weak_func').field('dimensionless').component({'v'});
model.physics('v_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v_weak_func').feature('ibweak1').selection.all;
model.physics('v_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v_weak_func').feature('weak1').selection.set([3]);
model.physics('v_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('p_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p_weak_func').identifier('p_weak_func');
model.physics('p_weak_func').field('dimensionless').field('p');
model.physics('p_weak_func').field('dimensionless').component({'p'});
model.physics('p_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p_weak_func').feature('ibweak1').selection.all;
model.physics('p_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p_weak_func').feature('weak1').selection.set([3]);
model.physics('p_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('u1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u1_weak_func').identifier('u1_weak_func');
model.physics('u1_weak_func').field('dimensionless').field('u1');
model.physics('u1_weak_func').field('dimensionless').component({'u1'});
model.physics('u1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak1').selection.all;
model.physics('u1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak1').selection.set([3]);
model.physics('u1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak2').selection.all;
model.physics('u1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak2').selection.set([3]);
model.physics('u1_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('u1_weak_func').create('weak4', 'WeakContribution', 1);
model.physics.create('v1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v1_weak_func').identifier('v1_weak_func');
model.physics('v1_weak_func').field('dimensionless').field('v1');
model.physics('v1_weak_func').field('dimensionless').component({'v1'});
model.physics('v1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak1').selection.all;
model.physics('v1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak1').selection.set([3]);
model.physics('v1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak2').selection.all;
model.physics('v1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak2').selection.set([3]);
model.physics('v1_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('v1_weak_func').create('weak4', 'WeakContribution', 1);
model.physics.create('p1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p1_weak_func').identifier('p1_weak_func');
model.physics('p1_weak_func').field('dimensionless').field('p1');
model.physics('p1_weak_func').field('dimensionless').component({'p1'});
model.physics('p1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p1_weak_func').feature('ibweak1').selection.all;
model.physics('p1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak1').selection.set([3]);
model.physics('p1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('u2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u2_weak_func').identifier('u2_weak_func');
model.physics('u2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak1').selection.all;
model.physics('u2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak2').selection.all;
model.physics('u2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak1').selection.set([3]);
model.physics('u2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak2').selection.set([3]);
model.physics('u2_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('u2_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('v2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v2_weak_func').identifier('v2_weak_func');
model.physics('v2_weak_func').field('dimensionless').field('v2');
model.physics('v2_weak_func').field('dimensionless').component({'v2'});
model.physics('v2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak1').selection.all;
model.physics('v2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak2').selection.all;
model.physics('v2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak1').selection.set([3]);
model.physics('v2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak2').selection.set([3]);
model.physics('v2_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('v2_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('p2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p2_weak_func').identifier('p2_weak_func');
model.physics('p2_weak_func').field('dimensionless').field('p2');
model.physics('p2_weak_func').field('dimensionless').component({'p2'});
model.physics('p2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p2_weak_func').feature('ibweak1').selection.all;
model.physics('p2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p2_weak_func').feature('weak1').selection.set([3]);
model.physics('p2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p2_weak_func').feature('weak2').selection.set([1 2 4]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.all;

model.result.table.create('evl2', 'Table');

model.variable('var2').label('all_funs_setting');
model.variable('var3').label('stokes_init0_setting');
model.variable('var4').label('ns_step1_setting');
model.variable('var5').label('ns_step2_setting');
model.variable('var1').active(false);

model.view('view1').axis.set('abstractviewxscale', '0.0020295202266424894');
model.view('view1').axis.set('ymin', '-0.17394667863845825');
model.view('view1').axis.set('xmax', '1.024999976158142');
model.view('view1').axis.set('abstractviewyscale', '0.0020295202266424894');
model.view('view1').axis.set('abstractviewbratio', '-0.04999998211860657');
model.view('view1').axis.set('abstractviewtratio', '0.04999995231628418');
model.view('view1').axis.set('abstractviewrratio', '0.39298880100250244');
model.view('view1').axis.set('xmin', '-0.024999964982271194');
model.view('view1').axis.set('abstractviewlratio', '-0.3929888904094696');
model.view('view1').axis.set('ymax', '1.1739466190338135');
model.view('view2').axis.set('ymin', '-1.3080406188964844');
model.view('view2').axis.set('xmax', '2.2925000190734863');
model.view('view2').axis.set('xmin', '-1.5924999713897705');
model.view('view2').axis.set('ymax', '1.708040714263916');

model.cpl('intop1').label('area_int');
model.cpl('intop1').set('opname', 'a_int');

model.physics('u_weak_func').label('stokes_init0_u');
model.physics('u_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u_weak_func').feature('wfeq1').set('weak', 'nu*(d(u,x)*test(d(u,x))+d(u,y)*test(d(u,y)))-p*test(d(u,x))-f1*test(u)');
model.physics('u_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*unx');
model.physics('u_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('u_weak_func').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*0-nu*sigma/h^beta*test(u)*0');
model.physics('v_weak_func').label('stokes_init0_v');
model.physics('v_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v_weak_func').feature('wfeq1').set('weak', 'nu*(d(v,x)*test(d(v,x))+d(v,y)*test(d(v,y)))-p*test(d(v,y))-f2*test(v)');
model.physics('v_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*uny');
model.physics('v_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');
model.physics('v_weak_func').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*0-nu*sigma/h^beta*test(v)*0');
model.physics('p_weak_func').label('stokes_init0_p');
model.physics('p_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p_weak_func').feature('wfeq1').set('weak', '-test(p)*(d(u,x)+d(v,y))+test(p)*p*1e-6');
model.physics('p_weak_func').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*unx+vjump*uny)');
model.physics('p_weak_func').feature('weak1').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(g1*nx+g2*ny)');
model.physics('p_weak_func').feature('weak2').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(0*nx+0*ny)');
model.physics('u1_weak_func').label('ns_step1_u1');
model.physics('u1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u1_weak_func').feature('wfeq1').set('weak', 'nu*(u1x*test(u1x)+u1y*test(u1y))+(u*u1x+v*u1y)*test(u1)+0.5*(d(u,x)+d(v,y))*u1*test(u1)-p1*test(u1x)-f1*test(u1)');
model.physics('u1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u1jump*testu1jump-nu*u1navg*testu1jump+nu*eipsilon*testu1navg*u1jump+p1avg*testu1jump*unx');
model.physics('u1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*g1-nu*sigma/h^beta*test(u1)*g1');
model.physics('u1_weak_func').feature('ibweak2').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(u1))*(down(u1)-up(u1))+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(u1))*(up(u1)-down(u1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(u1*test(u1))+down(u1*test(u1))))');
model.physics('u1_weak_func').feature('weak2').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(u1))*(down(u1)-g1)+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(u1))*(up(u1)-g1)-0.5*(u*nx+v*ny)*(u1*test(u1))');
model.physics('u1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*0-nu*sigma/h^beta*test(u1)*0');
model.physics('u1_weak_func').feature('weak4').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(u1))*(down(u1)-0)+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(u1))*(up(u1)-0)-0.5*(u*nx+v*ny)*(u1*test(u1))');
model.physics('v1_weak_func').label('ns_step1_v1');
model.physics('v1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v1_weak_func').feature('wfeq1').set('weak', 'nu*(v1x*test(v1x)+v1y*test(v1y))+(u*v1x+v*v1y)*test(v1)+0.5*(d(u,x)+d(v,y))*v1*test(v1)-p1*test(v1y)-f2*test(v1)');
model.physics('v1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v1jump*testv1jump-nu*v1navg*testv1jump+nu*eipsilon*testv1navg*v1jump+p1avg*testv1jump*uny');
model.physics('v1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*g1-nu*sigma/h^beta*test(v1)*g2');
model.physics('v1_weak_func').feature('ibweak2').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(v1))*(down(v1)-up(v1))+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(v1))*(up(v1)-down(v1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(v1*test(v1))+down(v1*test(v1))))');
model.physics('v1_weak_func').feature('weak2').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(v1))*(down(v1)-g2)+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(v1))*(up(v1)-g2)-0.5*(u*nx+v*ny)*(v1*test(v1))');
model.physics('v1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*0-nu*sigma/h^beta*test(v1)*0');
model.physics('v1_weak_func').feature('weak4').set('weakExpression', '(d(u,x)*dnx+d(u,y)*dny<0)*(d(u,x)*dnx+d(u,y)*dny)*test(down(v1))*(down(v1)-0)+(d(u,x)*unx+d(u,y)*uny<0)*(d(u,x)*unx+d(u,y)*uny)*test(up(v1))*(up(v1)-0)-0.5*(u*nx+v*ny)*(v1*test(v1))');
model.physics('p1_weak_func').label('ns_step1_p1');
model.physics('p1_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p1_weak_func').feature('wfeq1').set('weak', '-test(p1)*(u1x+v1y)+test(p1)*p1*1e-6');
model.physics('p1_weak_func').feature('ibweak1').set('weakExpression', 'testp1avg*(u1jump*unx+v1jump*uny)');
model.physics('p1_weak_func').feature('weak1').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(g1*nx+g2*ny)');
model.physics('p1_weak_func').feature('weak2').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(0*nx+0*ny)');
model.physics('u2_weak_func').label('ns_step2_u2');
model.physics('u2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u2_weak_func').feature('wfeq1').set('weak', 'nu*(u2x*test(u2x)+u2y*test(u2y))+(u1*u2x+v1*u2y)*test(u2)+0.5*(u1x+v1y)*u2*test(u2)-p2*test(u2x)-f1*test(u2)');
model.physics('u2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u2jump*testu2jump-nu*u2navg*testu2jump+nu*eipsilon*testu2navg*u2jump+p2avg*testu2jump*unx');
model.physics('u2_weak_func').feature('ibweak2').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(u2))*(down(u2)-up(u2))+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(u2))*(up(u2)-down(u2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(u2*test(u2))+down(u2*test(u2))))');
model.physics('u2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u2*test(u2)-nu*u2n*test(u2)+nu*eipsilon*testu2n*u2+p2*test(u2)*nx-nu*eipsilon*testu2n*g1-nu*sigma/h^beta*test(u2)*g1');
model.physics('u2_weak_func').feature('weak2').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(u2))*(down(u2)-g1)+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(u2))*(up(u2)-g1)-0.5*(u1*nx+v1*ny)*(u2*test(u2))');
model.physics('u2_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*u2*test(u2)-nu*u2n*test(u2)+nu*eipsilon*testu2n*u2+p2*test(u2)*nx-nu*eipsilon*testu2n*0-nu*sigma/h^beta*test(u2)*0');
model.physics('u2_weak_func').feature('weak4').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(u2))*(down(u2)-0)+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(u2))*(up(u2)-0)-0.5*(u1*nx+v1*ny)*(u2*test(u2))');
model.physics('v2_weak_func').label('ns_step2_v2');
model.physics('v2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v2_weak_func').feature('wfeq1').set('weak', 'nu*(v2x*test(v2x)+v2y*test(v2y))+(u1*v2x+v1*v2y)*test(v2)+0.5*(u1x+v1y)*v2*test(v2)-p2*test(v2y)-f2*test(v2)');
model.physics('v2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v2jump*testv2jump-nu*v2navg*testv2jump+nu*eipsilon*testv2navg*v2jump+p2avg*testv2jump*uny');
model.physics('v2_weak_func').feature('ibweak2').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(v2))*(down(v2)-up(v2))+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(v2))*(up(v2)-down(v2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(v2*test(v2))+down(v2*test(v2))))');
model.physics('v2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v2*test(v2)-nu*v2n*test(v2)+nu*eipsilon*testv2n*v2+p2*test(v2)*ny-nu*eipsilon*testv2n*g1-nu*sigma/h^beta*test(v2)*g2');
model.physics('v2_weak_func').feature('weak2').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(v2))*(down(v2)-g2)+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(v2))*(up(v2)-g2)-0.5*(u1*nx+v1*ny)*(v2*test(v2))');
model.physics('v2_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*v2*test(v2)-nu*v2n*test(v2)+nu*eipsilon*testv2n*v2+p2*test(v2)*ny-nu*eipsilon*testv2n*0-nu*sigma/h^beta*test(v2)*0');
model.physics('v2_weak_func').feature('weak4').set('weakExpression', '(u1x*dnx+u1y*dny<0)*(u1x*dnx+u1y*dny)*test(down(v2))*(down(v2)-0)+(u1x*unx+u1y*uny<0)*(u1x*unx+u1y*uny)*test(up(v2))*(up(v2)-0)-0.5*(u1*nx+v1*ny)*(v2*test(v2))');
model.physics('p2_weak_func').label('ns_step2_p2');
model.physics('p2_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p2_weak_func').feature('wfeq1').set('weak', '-test(p2)*(u2x+v2y)+test(p2)*p2*1e-6');
model.physics('p2_weak_func').feature('ibweak1').set('weakExpression', 'testp2avg*(u2jump*unx+v2jump*uny)');
model.physics('p2_weak_func').feature('weak1').set('weakExpression', 'test(p2)*(u2*nx+v2*ny)-test(p2)*(g1*nx+g2*ny)');
model.physics('p2_weak_func').feature('weak2').set('weakExpression', 'test(p2)*(u2*nx+v2*ny)-test(p2)*(0*nx+0*ny)');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1/16');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').run;

model.frame('material1').sorder(1);

model.result.table('evl2').label('Evaluation 2D');
model.result.table('evl2').comments([native2unicode(hex2dec({'4e' 'a4'}), 'unicode')  native2unicode(hex2dec({'4e' '92'}), 'unicode')  native2unicode(hex2dec({'76' '84'}), 'unicode')  native2unicode(hex2dec({'4e' '8c'}), 'unicode')  native2unicode(hex2dec({'7e' 'f4'}), 'unicode')  native2unicode(hex2dec({'50' '3c'}), 'unicode') ]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'u_weak_func' 'on' 'v_weak_func' 'on' 'p_weak_func' 'on' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'on' 'v1_weak_func' 'on'  ...
'p1_weak_func' 'on' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'on' 'v2_weak_func' 'on' 'p2_weak_func' 'on'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').attach('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature.remove('fcDef');

model.result.create('pg1', 'PlotGroup2D');
model.result.create('pg2', 'PlotGroup2D');
model.result.create('pg3', 'PlotGroup2D');
model.result.create('pg4', 'PlotGroup2D');
model.result.create('pg5', 'PlotGroup2D');
model.result.create('pg6', 'PlotGroup2D');
model.result.create('pg7', 'PlotGroup2D');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg2').create('surf1', 'Surface');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg6').set('data', 'dset3');
model.result('pg6').create('surf1', 'Surface');
model.result('pg7').set('data', 'dset3');
model.result('pg7').create('surf1', 'Surface');
model.result('pg8').set('data', 'dset3');
model.result('pg8').create('surf1', 'Surface');

model.study('std1').label('solve_stokes_init0_uvp');
model.study('std2').label('solve_ns_step1_u1v1p1');
model.study('std3').label('solve_ns_step2_u2v2p2');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

%% next is my loop
model.physics.remove('u_weak_func');
model.physics.remove('v_weak_func');
model.physics.remove('p_weak_func');
model.result.dataset.remove('dset1');
% model.variable('var1').set('u', 'u2');
% model.variable('var1').set('v', 'v2');
% model.variable('var1').set('p', 'p2');

for k=1:5
    
    model.variable.create('var6');
    model.variable('var6').model('comp1');
    model.variable('var6').set('u', 'u2');
    model.variable('var6').set('v', 'v2');
    model.variable('var6').set('p', 'p2');
    
    model.sol('sol2').attach('std2');
    model.sol('sol2').runAll;
    model.variable.remove('var6'); 
    
    model.sol('sol3').attach('std3');
    model.sol('sol3').runAll;
end


%% picture
% model.result('pg1').feature('surf1').set('expr', 'pexac');
% model.result('pg1').feature('surf1').set('descr', '');
% model.result('pg2').feature('surf1').set('expr', 'p');
% model.result('pg2').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' p']);
% model.result('pg3').feature('surf1').set('expr', 'u1');
% model.result('pg3').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u1']);
% model.result('pg4').feature('surf1').set('expr', 'v1');
% model.result('pg4').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' v1']);
% model.result('pg5').feature('surf1').set('expr', 'p1');
% model.result('pg5').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' p1']);
% model.result('pg6').feature('surf1').set('expr', 'u2');
% model.result('pg6').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u2']);
% model.result('pg7').feature('surf1').set('expr', 'v2');
% model.result('pg7').feature('surf1').set('descr', 'v2');
% model.result('pg8').feature('surf1').set('expr', 'p2');
% model.result('pg8').feature('surf1').set('descr', 'p2');

%out = model;
